module Zorkda
	module Actors

    #DONE
		class HeartContainer < HeartPiece
			def initialize (name, description, distance)
				super(name, distance, description)
				@gen_plural = "heart containers"
				@gen_singular = "heart container"
				if name == nil
					super(@gen_singular, description, distance)
				else
					super(name, description, distance)
				end
				@value = 4
			end
		end

	end
end