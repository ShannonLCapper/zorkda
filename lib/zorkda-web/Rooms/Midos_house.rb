module Zorkda
	module Rooms

		#DONE
		class Midos_house < Room

			def initialize
				super()
				@name = "Mido's House"
				@description = "Mido's treehouse is small, but it's dominated by a big pedestal at the far end."
				@sside = Door.new("south")
				@nside.change_type(:wooden_wall)
				@eside.change_type(:wooden_wall)
				@wside.change_type(:wooden_wall)
				@uside.change_type(:ceiling)
				@inventory = [
					Zorkda::Actors::Chest.new(nil, nil, 0, [Zorkda::Actors::Heart.new(nil, nil, false)]),
					Zorkda::Actors::Chest.new(nil, nil, 0, [Zorkda::Actors::GreenRupee.new(nil, nil, false)]),
					Zorkda::Actors::Chest.new(nil, nil, 0, [Zorkda::Actors::BlueRupee.new(nil, nil, false)]),
					Zorkda::Actors::Chest.new(nil, nil, 0, [Zorkda::Actors::BlueRupee.new(nil, nil, false)])
				]
			end
		end

	end
end