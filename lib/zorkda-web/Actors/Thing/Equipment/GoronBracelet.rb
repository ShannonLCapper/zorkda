module Zorkda
	module Actors

    #DONE
		class GoronBracelet < Equipment
      def initialize
        super("Goron bracelet", "bracelet", "bracelet", "bracelets")
        @acquired_description = "You can now pull up Bomb Flowers. Pick them up using the command &quot;pick up&quot;. Once you pick up a bomb flower, you have three more moves before it explodes."
        @strength = 1
        @available_as_adult = false
      end
    end

	end
end