module Zorkda
	module Actors

    #DONE
		class Rock < TerrainItem
			
			attr_accessor :break_when_thrown
			
			def initialize(name, description, distance, contents)
				super(name, description, distance)
				if contents.is_a?(String) && contents.upcase == "RNG"
					@random_contents = true
					@contents = nil
				else
					@contents = contents
				end
				@weight = 0
				@break_when_thrown = true
				@breakable = true
				@gen_singular = "rock"
				@gen_plural = "rocks"
				@respawn = true
				@drop_name_if_picked_up = true
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end