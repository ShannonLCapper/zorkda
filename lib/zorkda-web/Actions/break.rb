module Zorkda
	module Actions

		def self.break(game_status, target, with_obj)
			player = game_status.player
			curr_room = game_status.curr_room
			move_counter = game_status.move_counter
			with_obj = self::Utils.equate_with_obj_to_obj_player_has(player, with_obj, "break")
			if with_obj == nil
				return
			elsif !with_obj.can_hit_things
				Zorkda::GameOutput.add_line("That's not something you can break things with.")
				return
			end
			matches = self::Utils.find_matches_search_all(curr_room, target)
			if matches.length == 0
				Zorkda::GameOutput.add_line("Your target is either not here or not something with which you can interact.")
				return
			#if more than one thing matches, ask to be more specific
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to break.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Retype the &quot;break&quot; command with the target you want.")
				return
			else
				target = matches[0]
				if target.distance > with_obj.range
					Zorkda::GameOutput.add_line("Your target is too far away.")
				elsif !target.breakable
					Zorkda::GameOutput.add_line("That's not something you can break.")
				else
					with_obj.use(game_status, target)
				end
			end
		end

	end
end