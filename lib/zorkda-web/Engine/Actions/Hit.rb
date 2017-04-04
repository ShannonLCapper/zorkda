def hit(game_status, target, with_obj)
	player = game_status.player
	curr_room = game_status.curr_room
	move_counter = game_status.move_counter
	with_obj = equate_with_obj_to_obj_player_has(player, with_obj, "hit")
	if with_obj == nil
		return
	elsif !with_obj.can_hit_things
		puts "That's not something you can hit things with."
		return
	end
	matches = find_matches_search_all(curr_room, target)
	if matches.length == 0
		puts "Your target is either not here or not something with which you can interact."
		return
	#if more than one thing matches, ask to be more specific
	elsif matches.length > 1
		puts "You're going to have to be more specific about what you want to hit."
		list_options(matches)
		puts "Retype the \"hit\" command with the target you want."
		return
	else
		target = matches[0]
		with_obj.use(game_status, target)
	end
end

