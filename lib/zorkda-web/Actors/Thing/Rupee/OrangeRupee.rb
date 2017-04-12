module Zorkda
	module Actors

		#DONE
		class OrangeRupee < Rupee

			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "orange rupees"
				@gen_singular = "orange rupee"
				@value = 100
				if @name == nil
					@name = @gen_singular
				end
			end
		end

	end
end