module Zorkda
  module Rooms

  	#DONE
    class Twins_house < Room

			def initialize
				super()
				@name = "House of Twins"
				@description = "You stand in a small, humble treehouse with two beds in it."
				@wside = Door.new("west")
				@nside.change_type(:wooden_wall)
				@sside.change_type(:wooden_wall)
				@eside.change_type(:wooden_wall)
				@uside.change_type(:ceiling)
				@inventory = [Zorkda::Actors::Pot.new(nil, nil, 0, "RNG"), Zorkda::Actors::Pot.new(nil, nil, 0, "RNG")]
				@characters = [Zorkda::Actors::HouseOfTwinsKokiri.new]
			end
		end

  end
end