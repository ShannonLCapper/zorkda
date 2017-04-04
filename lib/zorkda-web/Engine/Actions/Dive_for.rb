def dive_for(game_status, obj)
	curr_room = game_status.curr_room
	player = game_status.player
	if player.carrying != nil
		puts "You must drop whatever you're carrying in your arms before you can dive."
		return
	end
 	matches = find_matches_search_all(curr_room, obj)
 	if matches.length == 0
 		puts "That target is either not here or not something you can interact with."
 		puts "If you're trying to dive to an underwater passageway, just type \"go down\"."
 	elsif curr_room.underwater
 		puts "You can't dive when you're already underwater."
 	else
 		submerged_objects = []
 		matches.each do |match|
 			if match.submerged
 				submerged_objects << match
 			end
 		end
 		if submerged_objects.length == 0
 			if matches.length > 1
 				puts "None of those are submerged underwater."
 			else
 				puts "That's not submerged underwater."
 			end
 		elsif submerged_objects.length > 1
 			puts "You can only dive for one thing at a time."
 			list_options(submerged_objects)
 			puts "Type \"dive for\" and the item you want."
 		elsif submerged_objects[0].distance > 0
			if submerged_objects[0].gen_singular == submerged_objects[0].gen_plural
				puts "You can't reach the part of the room where those are."
			else
				puts "You can't reach the part of the room where that is."
			end
 		#link tries to make the dive
 		else
 			obj = submerged_objects[0]
 			if player.deku_sticks.on_fire
 				player.deku_sticks.extinguish
 			end
 			if obj.submerged_distance > player.diving_distance
 				if obj.is_a?(Enemy)
 					puts "You try to dive for the enemy, but it's too far below the water."
 				elsif obj.gen_plural == obj.gen_singular
 					puts "You try to dive for the #{obj.name}, but they're too far below the water."
 				elsif
 					puts "You try to dive for the #{obj.name}, but it's too far below the water."
 				end
 			elsif obj.is_a?(Enemy)
 				puts "You struggle with the enemy, but can't bring it to the surface."
 				obj.touch(game_status)
 			elsif obj.is_a?(Floor_switch)
 				if obj.pressure > player.weight
					puts "You dive and try to press the switch, but you aren't heavy enough to budge it."
				elsif obj.is_a?(Floor_switch_sticky)
					obj.activate(game_status.move_counter)
				else
					puts "You dive and press the switch down, but it pops right back up again."
					puts "Maybe you could use something to hold it down?"
				end
 			elsif !obj.can_pick_up
 				puts "You try to dive for the #{obj.name}, but you can't pick it up."
 			elsif obj.weight > 0
 				puts "You try to dive for the #{obj.name}, but it's too heavy to bring up to the surface."
 			#link picks up the object
 			else
 				if obj.gen_singular == obj.gen_plural
 					puts "You sucessfully dive for the #{obj.name} and pick them up."
 				else
 					puts "You sucessfully dive for the #{obj.name} and pick it up."
 				end
 				obj.pick_up(game_status)
 			end
 		end
 	end
end