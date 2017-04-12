module Zorkda
	module Actors

		#DONE
		class YellowRupee < Rupee

			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "yellow rupees"
				@gen_singular = "yellow rupee"
				@value = 10
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end