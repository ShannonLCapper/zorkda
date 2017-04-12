module Zorkda
	module Actions

		def self.cut(game_status, to_obj, with_obj)
			player = game_status.player
			curr_room = game_status.curr_room
			move_counter = game_status.move_counter
			#no weapon mentioned, default to sword
			if with_obj == nil
				sword_equipped = false
				player_has_sword = false
				player.equipment.each do |piece|
					if piece.type == "sword"
						player_has_sword = true
						if piece.equipped
							with_obj = piece
							sword_equipped = true
							break
						end
					end
				end
				if player_has_sword && !sword_equipped
					Zorkda::GameOutput.add_line("You need to equip your sword before you can use it.")
					return
				elsif sword_equipped == false
					Zorkda::GameOutput.add_line("You don't have anything to cut with.")
					return
				end
			#get item you're cutting with
			else
				with_obj = self::Utils.equate_with_obj_to_obj_player_has(player, with_obj, "cut")
				if with_obj == nil
					return
				elsif !with_obj.can_cut_things
					Zorkda::GameOutput.add_line("That's not something you can cut things with.")
					return
				end
			end
			#get item you're cutting
			matches = self::Utils.find_matches_search_all(curr_room, to_obj)
			if matches.length == 0
				Zorkda::GameOutput.add_line("Your target is either not here or not something with which you can interact.")
				return
			#if more than one thing matches, ask to be more specific
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to cut.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Retype the &quot;cut&quot; command with the target you want.")
				return
			else
				target = matches[0]
				with_obj.use(game_status, target)
			end
		end

	end
end