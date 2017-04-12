module Zorkda
  module Actors

  	#DONE
		class KfSeKokiri < Character

			def initialize
				super("Kokiri boy", "A Kokiri boy frustratedly pulls at a tuft of grass.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				if self.talked_to_checkpoints.length.zero?
					self.talked_to_checkpoints << game_status.checkpoint
					return [
						"That meanie, Mido, made me cut the grass at Saria's house. " +
						"Mido told Saria he would do it so she would like him, " +
						"but I'm the one doing all the work!",
						" ",
						"You and Saria are close friends, so will you help me cut the grass? " +
						"I'll let you keep anything that you find while cutting it. " +
						"You can cut things using the command &quot;cut &lt;object&gt;&quot;."
					]
				else
					return "You and Saria are close friends, so will you help me cut the grass? " +
									"I'll let you keep anything that you find while cutting it. " +
									"You can cut things using the command &quot;cut &lt;object&gt;&quot;."
				end
			end

		end

	end
end