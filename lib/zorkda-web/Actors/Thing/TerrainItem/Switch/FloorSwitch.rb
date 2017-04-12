module Zorkda
	module Actors

    #DONE
		class FloorSwitch < Switch
			
			attr_accessor :pressure, :held_down_by
			
			def initialize(name, description, distance, pressure)
				super(name, description, distance)
				@pressure = pressure
				@gen_singular = "floor switch"
				@gen_plural = "floor switches"
				@held_down_by = nil
				@can_step_on = true
				if @name == nil
					@name = @gen_singular
				end
			end

			def activate(move_counter)
				self.activated = true
				Zorkda::GameOutput.add_line("The #{self.name} has been pressed down.")
				self.moves_when_activated = move_counter
			end

			def deactivate(move_counter)
				self.moves_when_deactivated = move_counter
				self.activated = false
				Zorkda::GameOutput.add_line("The #{self.name} returns to its unpressed state.")
			end

			def update_held_down(room_inventory, move_counter)
				if self.held_down_by != nil && !room_inventory.include?(self.held_down_by)
					Zorkda::GameOutput.add_line("The #{self.name} is no longer being held down.")
					self.held_down_by = nil
					#for some reason, this method holds the switch down for 1 move longer than it should, so the -1 is to correct for that
					self.moves_when_activated = move_counter - 1
				end
			end

			def check_deactivation(move_counter)
				if self.activated == true && self.held_down_by == nil
					deactivate(move_counter)
				end
			end

		end

	end
end