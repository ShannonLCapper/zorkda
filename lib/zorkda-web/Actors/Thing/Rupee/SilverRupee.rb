module Zorkda
	module Actors

		#DONE
		class SilverRupee < Rupee

			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "silver rupees"
				@gen_singular = "silver rupee"
				@value = 200
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end