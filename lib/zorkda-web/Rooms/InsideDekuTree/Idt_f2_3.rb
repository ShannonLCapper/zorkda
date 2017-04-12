module Zorkda
  module Rooms

    #DONE
    class Idt_f2_3 < InsideDekuTree

			attr_accessor :ladder

			def initialize
				super("F2", "Small Room")
				@description = "You're in a small dead-end room."
				@eside = HighDoor.new("east")
				@inventory = [
					Zorkda::Actors::Chest.new(
            "big chest", 
            "A big chest sits in the center of the room.", 
            0, 
            [Zorkda::Actors::Slingshot.new]
          ),
					Zorkda::Actors::LadderSwitch.new,
					Zorkda::Actors::Weed.new(nil, nil, 0, [Zorkda::Actors::DekuSeeds.new]),
					Zorkda::Actors::Weed.new(nil, nil, 0, [Zorkda::Actors::DekuSeeds.new]),
					Zorkda::Actors::Weed.new(nil, nil, 0, [Zorkda::Actors::Heart.new(nil, nil, 0)]),
					Zorkda::Actors::Weed.new(nil, nil, 0, [Zorkda::Actors::Heart.new(nil, nil, 0)])
				]
				@ladder = @inventory[1]
				@navi_hint = "Look! Something is hanging up in that spiderweb by the door.
		It looks like an old ladder! But how can we get it down?"
			end

			def update_distances(game_status)
				if self.ladder.activated && self.eside.distance != 0
					Zorkda::GameOutput.add_line("You can now reach the east door.")
					self.eside.distance = 0
					self.navi_hint = nil
				end
			end
		end

  end
end