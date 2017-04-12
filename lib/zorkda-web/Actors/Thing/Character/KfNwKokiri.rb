module Zorkda
  module Actors

  	#DONE
		class KfNwKokiri < Character

			def initialize
				super("Kokiri boy", "A Kokiri boy is breaking a sweat while lifting rocks.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				return "You can pick up rocks with the command &quot;pick up <item>&quot;. " +
							 "Then you can throw them with &quot;throw &lt;item&gt;&quot; " +
							 "or drop them with &quot;drop &lt;item&gt;&quot;. " +
							 "Mean old Mido... he made me pick up the stones in front of his house."
			end
			
		end

	end
end