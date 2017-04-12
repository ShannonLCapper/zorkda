module Zorkda
	module Rooms

    #DONE
		class Barrier < Side
			
			@@errors = {
				:wooden_wall => "There's just a wooden wall there.", 
				:stone_wall => "There's just a stone wall there.", 
				:ceiling => "That's just the ceiling.", 
				:sky => "That's just the sky.",
				:air => "There's no way to get up from here.",
				:floor => "That's just the floor.", 
				:trees => "Dense trees block your path.",
				:wooden_fence => "A wooden fence is in the way.",
				:cliff_bottom => "A steep cliffside looms above you.",
				:cliff_top => "Unless you want to fall off a cliff, that is.",
				:counter => "You'd smack into the counter."
			}

			attr_accessor :error

			def initialize(direction, type)
				super(direction)
				@error = @@errors[type]
				@display = false
			end

			def give_collision_error
				Zorkda::GameOutput.add_line("You can't go that way. #{self.error}")
			end

			def change_type(type)
				self.error = @@errors[type]
			end
		end

	end
end