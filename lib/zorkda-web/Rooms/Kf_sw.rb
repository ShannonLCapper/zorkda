module Zorkda
  module Rooms

    #DONE
    class Kf_sw < Room

			def initialize
				super()
				@name = "Southwest"
				@description = "You stand in front of the Know It All Brothers' house. " +
											 "A sign points south that reads &quot;Kokiri Training Center this way&quot;."
				@location = "Kokiri Forest"
				@nside = Pathway.new("north")
				@sside = Pathway.new("south")
				@wside = Door.new("west")
				@eside = Pathway.new("east")
				@characters = [
					Zorkda::Actors::KfSwKokiri.new
				]
			end

		end

	end
end