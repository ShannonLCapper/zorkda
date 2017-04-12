module Zorkda
	module Actors

    #DONE
		class FloorSwitchSticky < FloorSwitch

			def initialize(name, description, distance, pressure, moves_to_reset)
				super(name, description, distance, pressure)
				@moves_to_reset = moves_to_reset
			end

			def check_deactivation(move_counter)
				if self.activated == true && self.held_down_by == nil && 
				move_counter > self.moves_when_activated + self.moves_to_reset
					deactivate(move_counter)
				end
			end
		end

	end
end