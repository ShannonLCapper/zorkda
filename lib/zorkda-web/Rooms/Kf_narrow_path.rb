module Zorkda
  module Rooms

    #DONE
    class Kf_narrow_path < Room

			attr_accessor :mido_talked_to

			def initialize
				super()
				@name = "Narrow Path"
				@location = "Kokiri Forest"
				@description = "You're standing along a narrow pathway with dense trees on either side."
				@eside = Pathway.new("east")
				@wside = FallenTrunkKokiri.new("west", false)
				@nside.change_type(:trees)
				@sside.change_type(:trees)
				@enemies = [
					Zorkda::Actors::WitheredDekuBaba.new(
						"North Deku baba", 
						"On the north side of the path, a withered deku baba sways, snapping its teeth at the sky.", 
						0
					),
					Zorkda::Actors::WitheredDekuBaba.new(
						"South Deku baba", 
						"Another withered deku baba stands on the south end of the path.", 
						0
					)
				]
				@mido_talked_to = false
			end

			def update_locks(game_status)
				if game_status.checkpoint == 2 && !self.mido_talked_to
					self.wside.block_path
					Zorkda::GameOutput.add_line("Mido walks up to block the east tree trunk")
					#self.characters << Mido
				elsif self.mido_talked_to && self.wside.blocked
					self.wside.unblock_path
					Zorkda::GameOutput.add_line("Mido grumpily walks away")
					self.characters = []
				end
			end

		end

	end
end