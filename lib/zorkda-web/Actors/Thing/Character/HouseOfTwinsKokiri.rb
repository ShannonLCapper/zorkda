module Zorkda
  module Actors

    #DONE
    class HouseOfTwinsKokiri < Character

    	def initialize
    		super("Kokiri girl", "A Kokiri girl sits on a stool", "Kokiri", 0, "Kokiri girl", "Kokiri girls")
    		@parent_alias = true
    		@parent_singular = "girl"
    		@parent_plural = "girls"
    	end

    	def dialogue(game_status)
    		return "My sister took some Rupees and went shopping at the store in the northeast corner. Tee hee!"
    	end
    end

  end
end