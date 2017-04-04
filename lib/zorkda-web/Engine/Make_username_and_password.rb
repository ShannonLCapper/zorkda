require 'json'

def make_username_and_password
	usernames_and_passwords_file = open(File.expand_path("../../Game_files/Usernames_and_passwords.txt", __FILE__), "r+")
	usernames_and_passwords_json = usernames_and_passwords_file.read
	if usernames_and_passwords_json == ""
		usernames_and_passwords_hash = {}
	else
		usernames_and_passwords_hash = JSON.load(usernames_and_passwords_json)
	end
	puts "First, you need to make a unique file name to retrieve your game in the future."
	puts "Your file name can contain no special characters."
	both_confirmed = false
	until both_confirmed == "yes"
		unique_username_found = false
		until unique_username_found
			print "File name:"
			username = $stdin.gets.chomp.downcase
			if usernames_and_passwords_hash[username] != nil
				puts "That file name is already taken."
			elsif (username =~ /[^a-zA-Z0-9_ ]/) != nil
				puts "Your file name cannot contain a special character."
			elsif username == ""
				puts "Your file name cannot be blank."
			else
				unique_username_found = true
			end
		end
		password_confirmed = false
		until password_confirmed
			print "Password:"
			password = $stdin.gets.chomp
			if (password =~ /[^a-zA-Z0-9_ ]/) != nil
				puts "Password cannot contain special characters."
			elsif password == ""
				puts "Your password cannot be blank."
			else
				password_confirmed = true
			end
		end
		puts "Are you happy with the file name \"#{username}\" and the password \"#{password}?\""
		both_confirmed = get_valid_yes_or_no
	end
	puts "Ok! Remember those, because you'll need them to access your game at a later date."
	usernames_and_passwords_hash[username] = password
	usernames_and_passwords_json = JSON.dump(usernames_and_passwords_hash)
	usernames_and_passwords_file.seek(0).truncate
	usernames_and_passwords_file.write(usernames_and_passwords_json)
	usernames_and_passwords_file.close
	return username
end