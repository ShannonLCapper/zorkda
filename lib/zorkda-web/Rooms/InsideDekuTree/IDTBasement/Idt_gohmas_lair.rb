module Zorkda
  module Rooms

    #DONE
    class Idt_gohmas_lair < IDTBasement

			def initialize
				super(nil, "Gohma's Lair")
				@description = "You stand in a huge, cavernous room surrounded in mist."
				@has_entry_cutscene = true
				@enemies = [Zorkda::Actors::Gohma.new]
			end

			def entry_cutscene(game_status)
				dialogue = [
					"You step through the doorway to enter a massive dark cave. " +
					"With a crash, a wall closes over the door behind you. You're trapped.",
					" ",
					"You look around, squinting to try to make out anything in the darkness. " +
					"Mist fills the room, but other than that it seems empty. " +
					"That's when you hear rustling noises coming from above you. ",
					" ",
					"Filled with dread, you look up. " +
					"A massive hairy spider with a single bulging eye looks back. ",
					" ",
					"Gohma, the giant parasitic arachnid, hurls herself to the ground in front of you. " +
					"She looms over you and lets out a bloodcurdling bellow, then crawls back up to the ceiling."
				]
				Zorkda::GameOutput.add_lines(dialogue)
			end
		end

  end
end