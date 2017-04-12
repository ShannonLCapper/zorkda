module Zorkda
  module Rooms

    #DONE
    class Idt_b1_3_east < IDTBasement

			def initialize
				super("B1", "Spiked Log Room (East end)")
				@description = "You stand at the east end of a room separated by a moat. " +
		                   "A platform floats back and forth across the moat, passing " +
                       "underneath a sharp spiked log."
				@eside = Door.new("east")
				@wside = BlockablePath.new(
          "west", 
          "there is a ledge reachable only via the platform", 
					"there is ledge reachable only via the platform", 
					true,
					"You try to ride the platform across the moat. " +
          "But the spiked log knocks you off as you pass beneath it."
        )
				@wside.blocked_damage = 0.5
				@inventory = [
          Zorkda::Actors::FloorSwitchSticky.new(
            nil, 
            "It looks like there might be a floor switch under the water", 
            0, 
            1, 
            2
          )
        ]
				@inventory[0].submerged = true
				@navi_hint = "If you see something submerged, you can dive for it with the command &quot;dive for <item>&quot;.
		I bet there are some interesting things down there!"
			end

			def update_locks(game_status)
				if self.inventory[0].activated && self.wside.blocked
					Zorkda::GameOutput.add_line("The water level drops, allowing more space between the floating platform and the spiked log.")
					@wside.unblock
				elsif !self.inventory[0].activated && !self.wside.blocked
					Zorkda::GameOutput.add_line("The water returns to its original height.")
				end
			end

			def update_navi_hint(game_status)
				if self.inventory[0].activated
					self.navi_hint = nil
				end
			end
		end

  end
end