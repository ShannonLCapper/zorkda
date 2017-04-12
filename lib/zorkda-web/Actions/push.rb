module Zorkda
	module Actions

		def self.push(game_status, obj)
			curr_room = game_status.curr_room
			player = game_status.player
			move_counter = game_status.move_counter
			#find matches
			matches = self::Utils.find_matches_search_all(curr_room, obj)
			#if there are no matches
			if matches.length == 0
				Zorkda::GameOutput.add_line("Your target is either not here or not something with which you can interact.")
				Zorkda::GameOutput.add_line("Make sure you're just typing &quot;push &lt;object&gt;&quot;.")
				return
			#if more than one thing matches, ask to be more specific
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Type &quot;push&quot; and the item you want.")
				return
			else
				obj = matches[0]
				if obj.distance > 0
					Zorkda::GameOutput.add_line("That's too far away.")
				elsif (obj.submerged || curr_room.underwater) && player.weight < 2
					Zorkda::GameOutput.add_line("That's underwater, and you can't push it while you're floating around.")
				elsif obj.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("What are you, five years old?")
				elsif obj.is_a?(Zorkda::Actors::Enemy)
					Zorkda::GameOutput.add_line("It turns out pushing is not a very effective battle technique.")
					obj.touch(game_status)
				elsif obj.is_a?(Zorkda::Actors::TerrainItem) && obj.can_slide
					if !obj.path_clear
						Zorkda::GameOutput.add_line("You can't push the #{obj.name} because there's something in the way.")
					elsif !obj.slid
						Zorkda::GameOutput.add_line("With a bit of elbow grease, the #{obj.name} slides over.")
						obj.slide(move_counter)
					elsif !obj.can_slide_back
						Zorkda::GameOutput.add_line("The #{obj.name} will no longer budge.")
					else
						Zorkda::GameOutput.add_line("You push the #{obj.name} back to its original position.")
						obj.unslide(move_counter)
					end
				else
					Zorkda::GameOutput.add_line("That's not really something you can push.")
				end
			end
		end

	end
end