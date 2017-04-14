module Zorkda
	module Engine

		#TODO
		class GameStatus

			attr_accessor :player, :curr_room, :move_counter, :checkpoint, 
			:brief, :navi, :child_rooms, :end_of_game

			def initialize(player, curr_room, child_rooms)
				@player = player
				@curr_room = curr_room
				@checkpoint = 0
				@move_counter = 0
				@brief = false
				@navi = Zorkda::Actors::Navi.new
				@child_rooms = child_rooms
				@end_of_game = false
			end

			def get_location
				area = self.curr_room.location
				area += " (#{self.curr_room.floor})" if self.curr_room.location && self.curr_room.floor
				return {
        	area: area,
        	room: self.curr_room.name
				}
			end

		end

	end
end