module Zorkda
	module Actors

		#DONE
		class PurpleRupee < Rupee

			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "purple rupees"
				@gen_singular = "purple rupee"
				@value = 50
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end