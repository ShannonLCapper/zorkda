def light(game_status, target, lighter)
	player = game_status.player
	curr_room = game_status.curr_room
	move_counter = game_status.move_counter
	if curr_room.underwater
		puts "You can't light things while you're underwater."
		return
	end
	#find lighter
	#look in the room for the lighter
	matches = find_matches_search_all(curr_room, lighter)
	if matches.length != 0
		if matches.length > 1
			puts "You're going to have to be more specific about what you want to light with."
			list_options(matches)
			puts "Retype the \"light\" command again."
			return
		elsif !matches[0].on_fire
			puts "You can't light things with something that isn't on fire."
			return
		else
			lighter = matches[0]
			holding_lighter = false
		end
	#if the lighter is something you're holding
	else
		match = equate_with_obj_to_obj_player_has(player, lighter, "light")
		if match == nil
			return
		elsif !match.on_fire
			puts "You can't light things with something that isn't on fire."
			return
		else
			lighter = match
			holding_lighter = true
		end
	end

	#find target
	matches = find_matches_search_all(curr_room, target)
	#if target is something in the room
	if matches.length > 0
		if matches.length > 1
			puts "You're going to have to be more specific about what you want to light."
			list_options(matches)
			puts "Retype the \"light\" command again."
			return
		elsif holding_lighter == false
			puts "You need to find some way of transporting the fire from one to the other."
			return
		else
			target = matches[0]
		end
	#search the player for the target
	else
		matches = find_matches(player.inventory, target).concat(find_matches(player.equipment, target)).concat(find_matches(player.carrying, target))
		if matches.length == 0
			puts "You can't light something you don't have."
			return
		elsif matches.length > 1
			puts "You're going to have to be more specific about what you want to light."
			list_options(matches)
			puts "Retype the \"light\" command again."
			return
		elsif holding_lighter == true
			puts "Calm down, MacGyver. You can't light one thing you're carrying with another thing you're carrying."
			return
		else
			target = matches[0]
		end
	end

	if holding_lighter
		if target.submerged
			puts "You can't light something that is underwater."
		elsif target.distance > lighter.range
			puts "That target is too far away to light."
		elsif target.is_a?(Character)
			puts "How would you like it if I set YOU on fire?"
		elsif !target.flammable
			puts "You're trying to light something that isn't flammable."
		elsif lighter.is_a?(Fire_arrows)
			lighter.use(game_status, target)
		else
			target.light(game_status)
		end
	else
		if !target.flammable
			puts "You're trying to light something that isn't flammable."
		elsif lighter.distance > 0
			puts "You can't reach the #{lighter.name}."
		elsif lighter.is_a?(Enemy)
			puts "You're a brave one, aren't you? That seems like a bad idea."
		else
			target.light(move_counter)
		end
	end

end