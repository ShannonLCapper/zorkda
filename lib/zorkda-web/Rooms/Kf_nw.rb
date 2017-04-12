module Zorkda
  module Rooms

    #DONE
    class Kf_nw < Room

			def initialize
				super()
				@name = "Northwest"
				@description = "You stand in front of Mido's house."
				@location = "Kokiri Forest"
				@nside = Door.new("north")
				@sside = Pathway.new("south")
				@eside = Pathway.new("east")
				@wside.change_type(:trees)
				@inventory = [
					Zorkda::Actors::Rock.new(nil, nil, 0, "RNG"), 
					Zorkda::Actors::Rock.new(nil, nil, 0, "RNG"), 
					Zorkda::Actors::Rock.new(nil, nil, 0, "RNG")
				]
				@characters = [Zorkda::Actors::KfNwKokiri.new]
			end
		end

	end
end