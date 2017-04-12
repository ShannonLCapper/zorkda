module Zorkda
	module Actors

    #DONE
		class DiamondSwitch < Switch
			
			def initialize(name, description, distance, moves_to_reset)
				super(name, description, distance)
				@moves_to_reset = moves_to_reset
				@gen_singular = "diamond switch"
				@gen_plural = "diamond switches"
				@hittable = true
				@effective_items = ["sword", "slingshot", "boomerang", 
					"bow", "bomb", "hookshot", "longshot", "stick", "hammer"]
				if @name == nil
					@name = @gen_singular
				end
			end

			def activate(move_counter)
				self.activated = true
				Zorkda::GameOutput.add_line("The #{self.name} glows yellow.")
				self.moves_when_activated = move_counter
			end

			def deactivate(move_counter)
				self.moves_when_deactivated = move_counter
				self.activated = false
				Zorkda::GameOutput.add_line("The #{self.name} returns to its inactive state.")
			end

			def check_deactivation(move_counter)
				if self.activated == true && move_counter > self.moves_when_activated + self.moves_to_reset
					deactivate(move_counter)
				end
			end
		end

	end
end