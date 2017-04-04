def open_obj(game_status, obj)
	curr_room = game_status.curr_room
	player = game_status.player
	matches = find_matches(player.carrying, obj)
	if matches.length != 0
		puts "That's not really something you can open."
		return
	end
	matches = find_matches_search_all(curr_room, obj)
	if matches.length == 0
		puts "Your target is either not here or not something with which you can interact."
		puts "Make sure you're just typing \"open <object>\"."
		puts "Doors will open automatically if you \"go\" in their direction."
	elsif matches.length > 1
		puts "You're going to have to be more specific about what you want to open."
		list_options(matches)
		puts "Type \"open\" and the name of the object you want."
	else
		obj = matches[0]
		if player.carrying != nil
			puts "Your hands are full. Drop whatever you're carrying first."
		elsif !obj.openable
			puts "That's not really something you can open."
		elsif obj.distance > 0
			puts "The #{obj.name} is too far away for you to reach."
		elsif (obj.submerged || curr_room.underwater) && player.weight < 2
			puts "The #{obj.name} is underwater, and you can't open it while floating around."
		elsif obj.is_open
			puts "The #{obj.name} is already open."
		else
			obj.open(player)
		end
	end
end
