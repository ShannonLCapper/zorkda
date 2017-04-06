module Zorkda

  module User
    require "bcrypt"
    require "json"

    def self.all_params_present?(params)
      params.each do |param|
        return false if !param || param.length.zero?
      end
      return true
    end

    def self.salt_and_encrypt_password(password)
      salt = SecureRandom.hex
      return self.encrypt_password(password, salt), salt
    end

    def self.encrypt_password(password, salt)
      password_salt = password + salt
      return BCrypt::Password.create(password_salt)
    end

    def self.passwords_match?(stored_password, salt, inputted_password)
      # NOTE: Because bcrypt is dumb, the encrypted password pbject
      # must come first in the equality statement!
      password_obj = BCrypt::Password.new(stored_password)
      return password_obj == inputted_password + salt
    end

    def self.generate_uuid
      # Generate a new uuid until a unique one is found and add to DB
      loop do
        uuid = SecureRandom.uuid
        result = Db.add_uuid(uuid)
        next if result == "taken"
        return uuid if result == "success"
        return "error"
      end
    end

    def self.sign_in(inputted_username, inputted_password)
      return 400 unless self.all_params_present?([inputted_username, inputted_password])
      username = inputted_username.downcase

      # Look up username in Users table
      user = Db.get_user(username)

      # return with server error if db read had an error
      return 500 if user == "read error"
      # username not found
      return 404 if user.nil?

      # check password and return 422 if no match
      return 422 unless self.passwords_match?(user[:password], user[:salt], inputted_password)

      # if valid username and correct password, return user's display_name and uuid
      return { username: user[:display_name], uuid: user[:uuid] }.to_json
    end

    def self.sign_up(display_name, password)
      return 400 unless self.all_params_present?([display_name, password])
      username = display_name.downcase
      # Check if username already exists
      existing_user = Db.get_user(username)

      # username already exists
      return 409 unless existing_user.nil?

      # Make and save a unique UUID to the Uuids table
      uuid = self.generate_uuid
      return 500 if uuid == "error"

      # Make encrypted password and salt
      encrypted_password, salt = self.salt_and_encrypt_password(password)

      # Make entry in Users table
      user_info = { 
          username: username,
          display_name: display_name,
          password: encrypted_password,
          uuid: uuid,
          salt: salt
        }
      result = Db.add_user(user_info)

      # If entry added successfully, return 201 status and user's username and uuid
      return [201, { username: display_name, uuid: uuid }.to_json] if result == "success"
      # If user entry was not made, delete the uuid from the Uuids table and return status code
      Db.delete_uuid(uuid)
      return 409 if result =="taken"
      return 500
    end

  end

end