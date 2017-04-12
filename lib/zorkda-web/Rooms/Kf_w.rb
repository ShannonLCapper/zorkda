module Zorkda
  module Rooms

    #DONE
    class Kf_w < Room

			def initialize
				super()
				@name = "West"
				@location = "Kokiri Forest"
				@description = nil
				@nside = Pathway.new("north")
				@sside = Pathway.new("south")
				@eside = Pathway.new("east")
				@wside = FallenTrunkKokiri.new("west", true)
				@characters = [Zorkda::Actors::KfWKokiri.new]
			end
		end

	end
end