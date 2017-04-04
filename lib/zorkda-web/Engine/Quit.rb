def quit
	puts "Are you sure you want to quit?"
	response = get_valid_yes_or_no
	if response == "yes"
		puts "Thanks for playing. Hyrule needs you, so come back soon!"
		exit(0)
	else
		puts "Back to the game then!"
	end
end