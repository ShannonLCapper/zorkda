module Zorkda
	module Actors

    #DONE
	class Pot < TerrainItem

			attr_accessor :break_when_thrown

			def initialize(name, description, distance, contents)
				super(name, description, distance)
				if contents.is_a?(String) && contents.upcase == "RNG"
					@random_contents = true
					@contents = nil
				else
					@contents = contents
				end
				@contents = contents
				@break_when_thrown = true
				@gen_singular = "pot"
				@gen_plural = "pots"
				@effective_items = ["sword", "slingshot", "boomerang", 
					"bow", "bomb", "hookshot", "stick", "hammer"]
				@respawn = true
				@can_roll_into = true
				@drop_name_if_picked_up = true
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end