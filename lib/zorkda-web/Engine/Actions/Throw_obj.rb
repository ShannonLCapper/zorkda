def throw_obj(game_status, thrown_obj, target)
	curr_room = game_status.curr_room
	player = game_status.player
	move_counter = game_status.move_counter
	if target != nil
		throw_at = true
	else
		throw_at = false
	end
	if player.carrying != nil && (thrown_obj == player.carrying.name.downcase || thrown_obj == player.carrying.gen_singular.downcase || thrown_obj == player.carrying.old_name)
		thrown_obj = player.carrying
	else
		matches = find_matches(player.equipment, thrown_obj)
		if matches.length > 0
			puts "Don't go throwing your equipment. You need that stuff."
			return
		else
			matches = find_matches(player.inventory, thrown_obj)
			if matches.length > 1
				puts "You're going to have to be more specific about what you want to throw."
				list_options(matches)
				return
			elsif matches.length == 0
				puts "You don't have that item to throw."
				return
			elsif player.carrying != nil && (thrown_obj != player.carrying.name.downcase && thrown_obj != player.carrying.gen_singular.downcase)
				puts "Your hands are full with something else. Get rid of that first."
				return
			else 
				thrown_obj = matches[0]
			end
		end
	end	
	if throw_at == false
		if thrown_obj.is_a?(Character)
			puts "You unceremoniously throw #{thrown_obj.name} to the ground. What a gentleman."
			curr_room.characters << thrown_obj
			player.carrying = nil
		elsif thrown_obj.is_a?(Inventory_weapon) && thrown_obj.can_throw
			thrown_obj.use(game_status, nil)
		elsif thrown_obj.is_a?(Inventory_item)
			puts "Hey! You need that! Don't go throwing it away."
		else
			puts "You roughly throw the #{thrown_obj.name} to the ground."
			if thrown_obj.breakable
				thrown_obj.break(curr_room, player)
			else
				curr_room.inventory << thrown_obj
			end
			player.carrying = nil
		end
	else
		matches = find_matches_search_all(curr_room, target)
		if matches.length == 0
			puts "Your target is either not here or not something with which you can interact."
			return
		#if more than one thing matches, ask to be more specific
		elsif matches.length > 1
			puts "You're going to have to be more specific about what you want to throw that at."
			list_options(matches)
			puts "Retype the \"throw\" command with the target you want."
			return
		else
			target = matches[0]
			if target.is_a?(Character)
				puts "It's not polite to throw things at people."
			elsif thrown_obj.is_a?(Inventory_weapon) && thrown_obj.can_throw
				thrown_obj.use(game_status, target)
			elsif thrown_obj.is_a?(Inventory_item)
				puts "Hey! Don't go throwing things that you need."
			elsif target.distance > 0
				puts "That target is too far away to throw things at."
			elsif thrown_obj.is_a?(Bomb_flower) || thrown_obj.is_a?(Lit_bomb)
				puts "You throw the #{thrown_obj.name} at the target, and it explodes."
				player.carrying = nil
				target.hit_with_bomb(game_status, thrown_obj.damage_enemy)
			else
				puts "You can't throw that at something. Just type \"throw #{thrown_obj.name}\"."
			end
		end
	end
end