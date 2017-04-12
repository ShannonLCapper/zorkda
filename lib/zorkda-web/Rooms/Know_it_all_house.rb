module Zorkda
	module Rooms

		#DONE
		class Know_it_all_house < Room

			def initialize
				super()
				@name = "Know It All Brothers' House"
				@description = "You stand in a small, humble treehouse with a fire pit in the middle."
				@eside = Door.new("east")
				@nside.change_type(:wooden_wall)
				@sside.change_type(:wooden_wall)
				@wside.change_type(:wooden_wall)
				@uside.change_type(:ceiling)
				@inventory = [Zorkda::Actors::Pot.new(nil, "a pot stands in the corner", 0, "RNG")]
				@characters = [
					Zorkda::Actors::KnowItAllBro1.new, 
					Zorkda::Actors::KnowItAllBro2.new, 
					Zorkda::Actors::KnowItAllBro3.new
				]
			end

		end

	end
end