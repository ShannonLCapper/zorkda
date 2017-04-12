module Zorkda
	module Actors

    #DONE
		class Switch < TerrainItem
			
			attr_accessor :activated, :moves_to_reset, :moves_when_activated,
			:parent_singular, :parent_plural, :parent_alias, :moves_when_deactivated
			
			def initialize(name, description, distance)
				super(name, description, distance)
				@activated = false
				@moves_to_reset = 0
				@moves_when_activated = 0
				@moves_when_deactivated = 1.0/0.0
				@can_pick_up = false
				@breakable = false
				@parent_alias = true
				@parent_singular = "switch"
				@parent_plural = "switches"
				@gen_plural = "switches"
				@gen_singular = "switch"
			end

			def hit(game_status)
				self.activate(game_status.move_counter)
			end

			def check_deactivation(move_counter)
			end

		end

	end
end