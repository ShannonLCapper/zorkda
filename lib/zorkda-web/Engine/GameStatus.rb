module Zorkda
	module Engine

		class GameStatus

			attr_accessor :player, :curr_room, :display_location, 
			:move_counter, :checkpoint, :brief, :navi, :child_rooms

			def initialize(player, curr_room, child_rooms)
				@player = player
				@curr_room = curr_room
				@display_location = Zorkda::Engine.get_location(curr_room)
				@checkpoint = 0
				@move_counter = 0
				@brief = false
				@navi = Navi.new
				@child_rooms = child_rooms
			end

		end

	end
end