module Zorkda
	module Actors

		#DONE
		class RedRupee < Rupee
			
			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "red rupees"
				@gen_singular = "red rupee"
				@value = 20
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end