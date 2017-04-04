def step_on(game_status, obj)
	curr_room = game_status.curr_room
	player = game_status.player
	move_counter = game_status.move_counter
	#find matches
	matches = find_matches_search_all(curr_room, obj)
	#if there are no matches
	if matches.length == 0
		puts "Your target is either not here or not something with which you can interact."
		return
	#if more than one thing matches, ask to be more specific
	elsif matches.length > 1
		puts "You're going to have to be more specific."
		list_options(matches)
		puts "Type \"step on\" and the item you want."
		return
	else
		obj = matches[0]
		if obj.distance > 0
			puts "That's too far away."
		elsif (obj.submerged || curr_room.underwater) && player.weight < 2
			puts "That's underwater, and you can't reach it while you're floating around."
		elsif obj.is_a?(Character)
			puts "Well that's not very nice."
		elsif obj.is_a?(Enemy)
			puts "Not the best battle strategy..."
			obj.touch(game_status)
		elsif !obj.can_step_on
			puts "That didn't do much."
		else
			if obj.pressure > player.weight
				puts "You try to step on the switch, but you aren't heavy enough to budge it."
			elsif obj.is_a?(Floor_switch_sticky)
				obj.activate(move_counter)
			else
				puts "You push the switch down with your foot, but it pops right back up again."
				puts "Maybe you could use something to hold it down?"
			end
		end
	end
end