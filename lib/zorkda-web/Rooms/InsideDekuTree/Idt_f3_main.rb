module Zorkda
  module Rooms

    #DONE
    class Idt_f3_main < InsideDekuTree

			def initialize
				super("F3", "Main Trunk")
				@description = "You stand on a narrow pathway at the top of the Deku Tree's interior."
				@dside = BlockablePath.new(
					"down",
					"you can see all the way to the first floor. Sure seems like a big drop from here..",
					"you can see all the way to the first floor. Sure seems like a big drop from here..",
					true,
					"You try to pass the Skulltula, but it attacks you and knocks you back."
				)
				@dside.blocked_damage = 0.5
				@eside = Opening.new("east")
				@wside = Door.new("west")
				@enemies = [
          Zorkda::Actors::Skulltula.new(
            nil, 
            "A Skulltula hangs between you and the drop-off.", 
            0
          )
        ]
			end

			def update_locks(game_status)
				if self.dside.blocked && self.enemies.length == 0
					Zorkda::GameOutput.add_line("The spider is no longer blocking the drop down.")
					@dside.unblock
				elsif !self.dside.blocked && self.enemies.length > 0
					@dside.block
				end
			end
		end

  end
end