module Zorkda
	module Actors

    #DONE
		class Gauntlets < Equipment
      def initialize(name, strength, gen_singular, gen_plural)
        super(name, "gauntlets", gen_singular, gen_plural)
        @strength = strength
        @available_as_child = false
        @parent_alias = true
        @parent_singular = "gauntlet"
        @parent_plural = "gauntlets"
        @replace_previous = true
      end
    end

    class SilverGauntlets < Gauntlets
      def initialize
        super("Silver Gauntlets", 1, "Silver Gauntlets", "Silver Gauntlets")
        @acquired_description = "When you wear them, you feel power in your arms, the power to lift big things with the command &quot;pick up&quot;. But these guantlets won't fit a kid."
      end
    end

    class GoldenGauntlets < Gauntlets
      def initialize
        super("Golden Gauntlets", 2, "Golden Gauntlets", "Golden Gauntlets")
        @acquired_description = "You can feel even more power coursing through your arms! Lift things with the command &quot;pick up&quot;."
      end
    end

	end
end