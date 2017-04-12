module Zorkda
	module Actions

		def self.talk_to(game_status, obj)
			curr_room = game_status.curr_room
			checkpoint = game_status.checkpoint
			matches = self::Utils.find_matches_search_all(curr_room, obj)
			if matches.length == 0
				Zorkda::GameOutput.add_line("Are you talking to yourself? There's no one here by that name.")
			elsif matches[0].is_a?(Zorkda::Actors::Enemy)
				Zorkda::GameOutput.add_line("Enemies aren't really big on intellectually stimulating conversations.")
			elsif !matches[0].is_a?(Zorkda::Actors::Character)
				Zorkda::GameOutput.add_line("Uh, you feeling ok? You can talk to an inanimate object, but it won't talk back.")
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be a little more specific about who you want to talk to.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Type &quot;talk to&quot; and the name of the person you want.")
			else
				person = matches[0]
				person.speak(game_status)
			end
		end

	end
end