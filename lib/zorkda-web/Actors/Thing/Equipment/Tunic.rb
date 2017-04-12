module Zorkda
	module Actors

    #DONE
		class Tunic < Equipment
      def initialize(name, available_as_child)
        gen_plural = "Tunics"
        super(name, "tunic", name, gen_plural)
        @available_as_child = available_as_child
        @parent_alias = true
        @parent_singular = "Tunic"
        @parent_plural = "Tunics"
      end
    end

    class GoronTunic < Tunic
      def initialize    
        super("Goron Tunic", false)
        @heat_resistance = 1
        @acquired_description = "This heat-resistant tunic is adult size, so it won't fit a kid. Going to a hot place? No worry!"
      end
    end

    class KokiriTunic < Tunic
      def initialize
        super("Kokiri Tunic", true)
        @equipped = true
      end
    end

    class ZoraTunic < Tunic
      def initialize
        super("Zora Tunic", false)
        @underwater_breathing = 1
        @acquired_description = "This diving suit is adult size, so it won't fit a kid. Wear it, and you won't drown underwater."
      end
    end

	end
end