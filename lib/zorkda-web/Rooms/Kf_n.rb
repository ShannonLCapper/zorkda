module Zorkda
  module Rooms

    #DONE
    class Kf_n < Room

			def initialize
				super()
				@name = "North"
				@description = nil
				@location = "Kokiri Forest"
				@wside = Pathway.new("west")
				@sside = Pathway.new("south")
				@eside = Pathway.new("east")
				@nside = FallenTrunkKokiri.new("north", true)
				@inventory = [Zorkda::Actors::Grass.new(nil, nil, 0, "RNG")]
				@characters = [Zorkda::Actors::KfWKokiri.new]
			end
		end

	end
end