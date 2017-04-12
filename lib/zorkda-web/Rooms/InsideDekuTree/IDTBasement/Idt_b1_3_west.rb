module Zorkda
  module Rooms

    #DONE
    class Idt_b1_3_west < IDTBasement

			attr_accessor :blok

			def initialize
				super("B1", "Spiked Log Room (West end)")
				@description = "You stand on a ledge at the west end of a room separated by a moat."
				@wside = HighDoor.new("west")
				@eside = Path.new("east", "there is land you can easily swim to")
				@navi_hint = "Blocks can be moved with the command &quot;push block&quot;."
				@inventory = [
					Zorkda::Actors::Block.new(
            nil, 
            "A block sits a small distance from the west wall.", 
            "A block sits against the west wall.", 
            0, 
            true, 
            false
          ),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
				@blok = @inventory[0]
				@enemies = [
          Zorkda::Actors::Skulltula.new(
            nil, 
            "A Skulltula hangs between the block and the wall.", 
            0
          )
        ]
				@enemies[0].respawn = false
			end

			def update_navi_hint(game_status)
				if self.blok.slid
					self.navi_hint = nil
				end
			end

			def update_distances(game_status)
				if self.enemies.length == 0 && !self.blok.path_clear
					self.blok.path_clear = true
				end
				if self.blok.slid && self.wside.distance > 0
					move_all_closer
				elsif !self.blok.slid && self.wside.distance == 0
					move_all_farther_if_needed
				end
			end
		end

  end
end