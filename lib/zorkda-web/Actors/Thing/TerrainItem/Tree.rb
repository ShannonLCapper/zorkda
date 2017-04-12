module Zorkda
	module Actors

    #DONE
		class Tree < TerrainItem

			def initialize(name, description, distance, contents)
				super(name, description, distance)
				if contents.is_a?(String) && contents.upcase == "RNG"
					@random_contents = true
					@contents = nil
				else
					@contents = contents
				end
				@can_pick_up = false
				@breakable = false
				@hookshotable = true
				@can_roll_into = true
				@gen_singular = "tree"
				@gen_plural = "trees"
				if name == nil
					@name = @gen_singular
				end
			end
		end

	end
end