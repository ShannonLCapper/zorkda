def push(game_status, obj)
	curr_room = game_status.curr_room
	player = game_status.player
	move_counter = game_status.move_counter
	#find matches
	matches = find_matches_search_all(curr_room, obj)
	#if there are no matches
	if matches.length == 0
		puts "Your target is either not here or not something with which you can interact."
		puts "Make sure you're just typing \"push <object>\"."
		return
	#if more than one thing matches, ask to be more specific
	elsif matches.length > 1
		puts "You're going to have to be more specific."
		list_options(matches)
		puts "Type \"push\" and the item you want."
		return
	else
		obj = matches[0]
		if obj.distance > 0
			puts "That's too far away."
		elsif (obj.submerged || curr_room.underwater) && player.weight < 2
			puts "That's underwater, and you can't push it while you're floating around."
		elsif obj.is_a?(Character)
			puts "What are you, five years old?"
		elsif obj.is_a?(Enemy)
			puts "It turns out pushing is not a very effective battle technique."
			obj.touch(game_status)
		elsif obj.is_a?(Terrain_item) && obj.can_slide
			if !obj.path_clear
				puts "You can't push the #{obj.name} because there's something in the way."
			elsif !obj.slid
				puts "With a bit of elbow grease, the #{obj.name} slides over."
				obj.slide(move_counter)
			elsif !obj.can_slide_back
				puts "The #{obj.name} will no longer budge."
			else
				puts "You push the #{obj.name} back to its original position."
				obj.unslide(move_counter)
			end
		else
			puts "That's not really something you can push."
		end
	end
end