module Zorkda
	module Actions

		def self.step_on(game_status, obj)
			curr_room = game_status.curr_room
			player = game_status.player
			move_counter = game_status.move_counter
			#find matches
			matches = self::Utils.find_matches_search_all(curr_room, obj)
			#if there are no matches
			if matches.length == 0
				Zorkda::GameOutput.add_line("Your target is either not here or not something with which you can interact.")
				return
			#if more than one thing matches, ask to be more specific
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Type &quot;step on&quot; and the item you want.")
				return
			else
				obj = matches[0]
				if obj.distance > 0
					Zorkda::GameOutput.add_line("That's too far away.")
				elsif (obj.submerged || curr_room.underwater) && player.weight < 2
					Zorkda::GameOutput.add_line("That's underwater, and you can't reach it while you're floating around.")
				elsif obj.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("Well that's not very nice.")
				elsif obj.is_a?(Zorkda::Actors::Enemy)
					Zorkda::GameOutput.add_line("Not the best battle strategy...")
					obj.touch(game_status)
				elsif !obj.can_step_on
					Zorkda::GameOutput.add_line("That didn't do much.")
				else
					if obj.pressure > player.weight
						Zorkda::GameOutput.add_line("You try to step on the switch, but you aren't heavy enough to budge it.")
					elsif obj.is_a?(Zorkda::Actors::FloorSwitchSticky)
						obj.activate(move_counter)
					else
						Zorkda::GameOutput.add_line("You push the switch down with your foot, but it pops right back up again.")
						Zorkda::GameOutput.add_line("Maybe you could use something to hold it down?")
					end
				end
			end
		end

	end
end