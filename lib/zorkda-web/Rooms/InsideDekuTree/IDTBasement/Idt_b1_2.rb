module Zorkda
  module Rooms

    #DONE
    class Idt_b1_2 < IDTBasement

			def initialize
				super("B1", "Round Room")
				@description = "You stand in a round stone room."
				@nside = Door.new("north")
				@wside = BarrableDoor.new("west", false)
				@inventory = [
					Zorkda::Actors::EyeSwitch.new(nil, "Above the west door, there is a metal eye switch", 5, 1.0/0.0),
					Zorkda::Actors::Weed.new(
            nil, 
            nil, 
            0, 
            Zorkda::Actors::Heart.new(nil, nil, false)
          ),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
				@enemies = [
					Zorkda::Actors::TalkingDekuScrub.new(
						nil, 
						"A deku scrub watches from the center of the room.", 
						0, 
						[
							"Wait! Plesae forgive me, master! I'll never do it again! " +
							"If you spare me, I'll teach you something cool.",
							" ",
							"You will never beat my brothers up ahead unless you punish them in the proper order. ",
							"The order is... 2    3    1",
							"Twenty-three is number one!",
							"Do you think I'm a traitor?"
						]
					)
				]
				@enemies[0].respawn = true
			end

			def update_locks(game_status)
				if self.inventory[0].activated && self.wside.blocked
					Zorkda::GameOutput.add_line("The bars lift from the west door.")
					self.wside.unblock
				elsif !self.inventory[0].activated && !self.wside.blocked
					Zorkda::GameOutput.add_line("Heavy bars slam over the west door.")
					self.wside.block
				end
			end

		end

  end
end