def roll_into(game_status, obj)
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
		puts "Type \"roll into\" and the item you want."
		return
	else
		obj = matches[0]
		if obj.distance > 0
			puts "That's too far away."
		elsif (obj.submerged || curr_room.underwater) && player.weight < 2
			puts "That's underwater, and you can't roll into it while you're floating around."
		elsif obj.is_a?(Character)
			puts "It's rather rude to roll into people."
		elsif obj.is_a?(Enemy)
				puts "Well that wasn't very smart."
				obj.touch(game_status)
		elsif !obj.can_roll_into
			puts "You roll, but not much happens."
		elsif obj.is_a?(Tree)
			if obj.contents != nil && obj.contents.length > 0
				print "You roll into the #{obj.name}, and it drops the following to the ground: "
				(obj.contents.length - 1).times do |i|
					print obj.contents[i].name
					if obj.contents.length > 2
						print ", "
					else
						print " "
					end
				end
				if obj.contents.length > 1
					print "and "
				end
				puts "#{obj.contents.last.name}"
				obj.contents.each do |item|
					if item.is_a?(Enemy)
						curr_room.enemies << item
					elsif item.is_a?(Character)
						curr_room.characters << item
					else
						curr_room.inventory << item
					end
				end
				obj.contents = []
			else
				puts "You roll into the #{obj.name}, but it just drops a few leaves."
			end
		elsif obj.breakable
			obj.break(player)
		else
			puts "You pick up the #{obj.name}."
			obj.pick_up(game_status)
		end
	end
end