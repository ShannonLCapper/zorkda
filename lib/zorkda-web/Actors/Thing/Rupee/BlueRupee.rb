module Zorkda
	module Actors

		#DONE
		class BlueRupee < Rupee

			attr_accessor :spawn_frequency

			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "blue rupees"
				@gen_singular = "blue rupee"
				@value = 5
				if @name == nil
					@name = @gen_singular
				end
				@spawn_frequency = 2
			end

		end

	end
end