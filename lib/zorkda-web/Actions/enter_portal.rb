module Zorkda
	module Actions

		def self.enter_portal(game_status)
			curr_room = game_status.curr_room
			if !curr_room.contains_portal
				Zorkda::GameOutput.add_line("There's no portal here to enter.")
			else
				game_status.curr_room = curr_room.portal_goes_to
				Zorkda::GameOutput.add_line("You walk into the portal, and its surrounds you in blue light, lifting you towards the ceiling.")
				2.times { Zorkda::GameOutput.new_paragraph}
				Zorkda::Engine.enter_room(game_status)
			end
		end

	end
end