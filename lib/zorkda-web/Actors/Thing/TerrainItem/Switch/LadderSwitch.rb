module Zorkda
	module Actors

    #DONE
		class LadderSwitch < Switch

			def initialize
				super("ladder", "there is a ladder suspended in cobwebs above the east door", 5)
				@moves_to_reset = 1.0/0.0
				@hittable = true
				@effective_items = ["slingshot"]
				@gen_singular = "ladder"
				@gen_plural = "ladders"
				@parent_alias = false
			end

			def activate(move_counter)
				self.activated = true
				Zorkda::GameOutput.add_line("The ladder falls from the cobwebs, landing propped against the east wall.")
				self.description = "there is a ladder resting against the east wall"
				self.moves_when_activated = move_counter
				self.distance = 0
				self.effective_items = []
			end

		end

	end
end