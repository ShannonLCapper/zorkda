module Zorkda
	module Actions

		def self.open_obj(game_status, obj)
			curr_room = game_status.curr_room
			player = game_status.player
			matches = self::Utils.find_matches(player.carrying, obj)
			if matches.length != 0
				Zorkda::GameOutput.add_line("That's not really something you can open.")
				return
			end
			matches = self::Utils.find_matches_search_all(curr_room, obj)
			if matches.length == 0
				text_lines = [
					"Your target is either not here or not something with which you can interact.",
					"Make sure you're just typing &quot;open &lt;object&gt;&quot;.",
					"Doors will open automatically if you &quot;go&quot; in their direction."
				]
				Zorkda::GameOutput.add_lines(text_lines)
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to open.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Type &quot;open&quot; and the name of the object you want.")
			else
				obj = matches[0]
				if player.carrying != nil
					Zorkda::GameOutput.add_line("Your hands are full. Drop whatever you're carrying first.")
				elsif !obj.openable
					Zorkda::GameOutput.add_line("That's not really something you can open.")
				elsif obj.distance > 0
					Zorkda::GameOutput.add_line("The #{obj.name} is too far away for you to reach.")
				elsif (obj.submerged || curr_room.underwater) && player.weight < 2
					Zorkda::GameOutput.add_line("The #{obj.name} is underwater, and you can't open it while floating around.")
				elsif obj.is_open
					Zorkda::GameOutput.add_line("The #{obj.name} is already open.")
				else
					obj.open(player)
				end
			end
		end

	end
end
