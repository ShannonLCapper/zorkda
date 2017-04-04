def go(game_status, side)
	curr_room = game_status.curr_room
	player = game_status.player
	move_counter = game_status.move_counter
	brief = game_status.brief
		if side == "north" || side == "n"
			side = curr_room.nside
		elsif side == "south" || side == "s"
			side = curr_room.sside
		elsif side == "west" || side == "w"
			side = curr_room.wside
		elsif side == "east" || side == "e"
			side = curr_room.eside
		elsif side == "up" || side == "u"
			side = curr_room.uside
		elsif side == "down" || side == "d"
			side = curr_room.dside
		else
			puts "I only understand \"go\" plus a direction."
			return
		end
		if side.distance > 0
			puts "That path is currently out of your reach."
		elsif (side.is_a?(Waterway) || side.is_a?(Blockable_water_path)) && side == curr_room.dside && 
		(player.weight < 2 || player.diving_distance < side.submerged_distance)
			puts "That path is too far under the water for you to reach by diving."
		elsif side.is_a?(Barrier)
			puts "You can't go that way. #{side.error}"
		elsif side.is_a?(Crawlway) && player.age == "adult"
			puts "I think you're a little too big to fit through there."
		elsif side.is_a?(Blockable_path) && side.blocked
			puts "#{side.blocked_attempt_message}"
			if side.blocked_damage > 0
				player.receive_damage(game_status, side.blocked_damage)
			end
			if side.on_fire
				player.on_fire
			elsif side.frozen
				player.freeze(move_counter)
			end
		elsif side.is_a?(Waterway) && side == curr_room.uside && player.weight > 1
			puts "You aren't buoyant enough to go that way."
		elsif curr_room.underwater && (side.is_a?(Door) || side.is_a?(Lockable_door) || 
		side.is_a?(Barrable_door)) && player.weight < 2
			puts "You can't go through a door while you're floating around."
		elsif side.is_a?(Crawlway) && player.deku_sticks.on_fire
			puts "It's not safe to go through that narrow crawl space with a lit deku stick."
		else
			game_status.curr_room = side.goes_to
			enter_room(game_status)
		end
	end