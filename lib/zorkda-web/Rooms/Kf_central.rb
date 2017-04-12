module Zorkda
  module Rooms

    #DONE
    class Kf_central < Room

			def initialize
				super()
				@name = "Central"
				@description = "A signpost reads: &quot;North: Lost Woods, West: Hyrule Field, East: Great Deku Tree&quot;"
				@location = "Kokiri Forest"
				@nside = Pathway.new("north")
				@sside = Pathway.new("south")
				@wside = Pathway.new("west")
				@eside = Pathway.new("east")
				@inventory = [Zorkda::Actors::BlueRupee.new(nil, "a blue rupee lies at the base of the sign", false)]
				@characters = [Zorkda::Actors::KfCentralKokiri.new]
			end

		end

	end
end