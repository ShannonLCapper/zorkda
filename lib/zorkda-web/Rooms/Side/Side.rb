module Zorkda
	module Rooms

		#DONE
		class Side
			attr_accessor :direction, :permeable, :distance, :original_distance, :on_fire, :frozen,
			:display

			def initialize(direction)
				@direction = direction
				@permeable = false
				@distance = 0
				@original_distance = distance
				@on_fire = false
				@frozen = false
				@display = true
			end

			def set_distance(distance)
				self.distance = distance
				self.original_distance = distance
			end
		end

	end
end