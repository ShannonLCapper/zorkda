def enter_portal(game_status)
	curr_room = game_status.curr_room
	if !curr_room.contains_portal
		puts "There's no portal here to enter."
	else
		game_status.curr_room = curr_room.portal_goes_to
		puts "You walk into the portal, and its surrounds you in blue light, lifting you towards the ceiling.\n\n"
		#puts "Would you like to save?"
		#response = get_valid_yes_or_no
		#if response == "yes"
		#	save(game_status)
		#end
		puts "\n\n"
		enter_room(game_status)
	end
end