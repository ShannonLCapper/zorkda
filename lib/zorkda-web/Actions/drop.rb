module Zorkda
	module Actions

		def self.drop(game_status, to_obj, on_obj)
			curr_room = game_status.curr_room
			player = game_status.player
			move_counter = game_status.move_counter
			if on_obj != nil
				drop_on = true
			else
				drop_on = false
			end
			#if you aren't carrying that item
			if player.carrying == nil || (to_obj != player.carrying.name.downcase && to_obj != player.carrying.gen_singular.downcase && to_obj != player.carrying.old_name)
				Zorkda::GameOutput.add_line("You can only drop something that you're currently carrying in your arms.")
			#if item is just being dropped on the ground
			elsif drop_on == false
				if player.carrying.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("You put down #{player.carrying.name}.")
				else
					Zorkda::GameOutput.add_line("You put down the #{player.carrying.name}.")
				end
				curr_room.inventory << player.carrying
				player.carrying = nil
			#if item is being dropped on something
			else
				#check if that thing is in the room
				matches = self::Utils.find_matches_search_all(curr_room, on_obj)
				#if nothing in the room matches
				if matches.length == 0
					Zorkda::GameOutput.add_line("Whatever you're trying to put that on is either not here or not something with which you can interact.")
					return
				#if more than one thing matches, ask to be more specific
				elsif matches.length > 1
					Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to put that down on.")
					return
				else
					recipient = matches[0]
				end
				#we now have only one recipient
				#if the recipient is too far away
				if recipient.distance > 0
					Zorkda::GameOutput.add_line("That target is currently too far away.")
				#if the recipient is a character, stop from dropping
				elsif recipient.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("Uh, no. People don't like it when you drop things on them.")
				#if the recipient is an enemy, drop but don't damage
				elsif recipient.is_a?(Zorkda::Actors::Enemy)
					if player.carrying.is_a?(Zorkda::Actors::Character)
						Zorkda::GameOutput.add_line("You dropped #{player.carrying.name} on the enemy, but its seems like you just pissed it off.")
					else
						Zorkda::GameOutput.add_line("You dropped the #{player.carrying.name} on the enemy, but its seems like you just pissed it off.")
					end
					curr_room.inventory << player.carrying
					player.carrying = nil
				#if the recipient is a floor switch
				elsif recipient.is_a?(Zorkda::Actors::FloorSwitch)
					if recipient.held_down_by != nil
						Zorkda::GameOutput.add_line("There's already something on that switch.")
						return
					elsif recipient.pressure <= player.carrying.weight
						if player.carrying.is_a?(Zorkda::Actors::Character)
							message = "You put down #{player.carrying.name}, and their weight holds the switch down."
						else
							message = "You put down the #{player.carrying.name}, and it holds the switch down."
						end
						recipient.activate(move_counter, message)
						recipient.held_down_by = player.carrying
					else
						if player.carrying.is_a?(Zorkda::Actors::Character)
							Zorkda::GameOutput.add_line("You place #{player.carrying.name} down, but they're not heavy enough to press the switch.")
						else
							Zorkda::GameOutput.add_line("You place the #{player.carrying.name} down, but it's not heavy enough to press the switch.")
						end
					end
					curr_room.inventory << player.carrying
					player.carrying = nil
				#if the recipient is a different terrain item or other object
				else
					Zorkda::GameOutput.add_line("That's not really something you can put things on.")
				end
			end
		end

	end
end