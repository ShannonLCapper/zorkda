module Zorkda
	module Actors

		#DONE
		class GreenRupee < Rupee

			attr_accessor :spawn_frequency

			def initialize(name, description, respawn)
				super(name, description, respawn)
				@gen_plural = "green rupees"
				@gen_singular = "green rupee"
				@value = 1
				if @name == nil
					@name = @gen_singular
				end
				@spawn_frequency = 8
			end
		end

	end
end