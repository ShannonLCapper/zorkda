module Zorkda
	module Actors

    #DONE
		class Scale < Equipment
			def initialize(name, diving_distance, gen_singular, gen_plural)
				super(name, "scale", gen_singular, gen_plural)
				@diving_distance = diving_distance
				@parent_alias = true
				@parent_singular = "scale"
				@parent_plural = "scales"
				@replace_previous = true
			end
		end

    class SilverScale < Scale
      def initialize
        super("Silver Scale", 1, "Silver Scale", "Silver Scales")
        @acquired_description = "Use the command &quot;dive for&quot; to pick up items below water. You can dive deeper than you could before."
      end
    end

    class GoldenScale < Scale
      def initialize
        super("Golden Scale", 2, "Golden Scale", "Golden Scales")
        @acquired_description = "Use the command &quot;dive for&quot; to pick up items below water. Now you can dive much deeper than you could before."
      end
    end

	end
end