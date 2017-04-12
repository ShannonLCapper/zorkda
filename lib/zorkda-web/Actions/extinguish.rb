module Zorkda
  module Actions

    def self.extinguish(game_status, obj)
    	if obj == "deku stick" || obj == "stick" || obj == "deku sticks" || obj == "sticks"
    		game_status.player.deku_sticks.extinguish
    	else
    		Zorkda::GameOutput.add_line("That's not something you can extinguish.")
    	end
    end

  end
end