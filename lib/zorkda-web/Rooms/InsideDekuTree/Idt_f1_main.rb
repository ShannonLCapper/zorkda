module Zorkda
  module Rooms

    #DONE
    class Idt_f1_main < InsideDekuTree

			def initialize
				super("F1", "Main Trunk")
				@description = "You stand on the ground floor of a massive tree trunk."
				@wside = Opening.new("west")
				@uside = Ladder.new("up")
				@dside = BlockablePath.new(
					"down",
					"there is a large hole covered in thick spiderweb",
					"there is a large hole",
					true,
					"The thick spiderweb stretches, but does not give way.")
				@inventory = [
          Zorkda::Actors::Spiderweb.new(nil, nil, 0), 
          Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"), 
          Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"),
          Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
        ]
				@inventory[0].display = false
				@enemies = [
          Zorkda::Actors::DekuBaba.new(nil, nil, 0), 
          Zorkda::Actors::DekuBaba.new(nil, nil, 0)
        ]
				@has_entry_cutscene = true
				@navi_hint = "Look, look! I think there's a tunnel below this web on the floor."
			end

			def entry_cutscene(game_status)
				dialogue = [
					"You walk through the Deku Tree's mouth and enter a massive circular room.",
					"The walls are made of bark, and vines and spiderwebs hang from the tall ceiling.",
		      "When you look up, you can see several more floors above your head."
		    ]
				Zorkda::GameOutput.add_lines(dialogue)
			end

		end

  end
end