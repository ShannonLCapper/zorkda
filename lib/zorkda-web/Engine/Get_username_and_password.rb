def get_username_and_password
	while true
		usernames_and_passwords_file = open(File.expand_path("../../Game_files/Usernames_and_passwords.txt", __FILE__), "r")
		usernames_and_passwords_json = usernames_and_passwords_file.read
		usernames_and_passwords_file.close
		if usernames_and_passwords_json == ""
			usernames_and_passwords_hash = {}
		else
			usernames_and_passwords_hash = JSON.parse(usernames_and_passwords_json)
		end
		print "Name of saved file: "
		file_name = $stdin.gets.chomp.downcase
		if usernames_and_passwords_hash[file_name] == nil
			puts "We don't have a saved game by that name."
		else
			print "File password: "
			password = $stdin.gets.chomp
			if usernames_and_passwords_hash[file_name] != password
				puts "That's not the right password."
			else
				return file_name
			end
		end
		valid_response = false
		until valid_response
			puts "Do you want to try again or go back?"
			response = prompt.downcase
			if response == "try again" || response == "again"
				valid_response = true
			elsif response == "back" || response == "go back"
				valid_response = true
				return nil
			else
				puts "That's not a valid option."
			end
		end
	end
end