module Zorkda
  module Actors
    
    #DONE
    class KfWKokiri < Character

			def initialize
				super("Kokiri boy", "A Kokiri boy blocks the path through the fallen trunk.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				checkpoint = game_status.checkpoint
				if checkpoint < 2
					return "You're not allowed to leave the forest! " +
								 "The Great Deku Tree said that if a Kokiri leaves the woods, " +
								 "he or she will die!"
				else
					return "I don't know what to say."
				end
			end
		end

	end
end