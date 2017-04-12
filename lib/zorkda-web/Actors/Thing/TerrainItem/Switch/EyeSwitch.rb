module Zorkda
	module Actors

    #DONE
		class EyeSwitch < Switch
			
			def initialize(name, description, distance, moves_to_reset)
				super(name, description, distance)
				@moves_to_reset = moves_to_reset
				@gen_singular = "eye switch"
				@gen_plural = "eye switches"
				@hittable = true
				@effective_items = ["bow", "slingshot"]
				if @name == nil
					@name = @gen_singular
				end
			end

			def activate(move_counter)
				self.activated = true
				Zorkda::GameOutput.add_line("The eye of the #{self.name} closes.")
				self.moves_when_activated = move_counter
			end

			def deactivate(move_counter)
				self.moves_when_deactivated = move_counter
				self.activated = false
				Zorkda::GameOutput.add_line("The eye of the #{self.name} returns to its open state.")
			end

			def check_deactivation(move_counter)
				if self.activated == true && move_counter > self.moves_when_activated + self.moves_to_reset
					deactivate(move_counter)
				end
			end

		end

	end
end