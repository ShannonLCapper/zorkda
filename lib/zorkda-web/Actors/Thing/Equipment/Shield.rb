module Zorkda
	module Actors

    class Shield < Equipment

      def initialize(
        name, 
        available_as_adult, 
        available_as_child, 
        susceptible_to_fire, 
        reflective
      )
        super(name, "shield", name, name + "s")
        @available_as_adult = available_as_adult
        @available_as_child = available_as_child
        @parent_alias = true
        @parent_singular = "shield"
        @parent_plural = "shields"
        @susceptible_to_fire = susceptible_to_fire
        @reflective = reflective
      end
    end

    class DekuShield < Shield

      def initialize
        super("Deku Shield", false, true, true, false)
        @acquired_description = "Since it's made of wood, if you get hit " +
        "with fire while it's equipped, it'll burn away. " +
        "You can use the shield with the command &quot;block&quot;. "
      end
    end

    class HylianShield < Shield

      def initialize
        super("Hylian Shield", true, false, false, false)
        @acquired_description = "This sturdy shield is made of metal, " +
        "so it won't burn. It's a bit too big for a kid to use."
      end
    end

    class MirrorShield < Shield

      def initialize
        super("Mirror Shield", true, false, false, true)
        @acquired_description = "This shield's polished surface can reflect light " +
        "or energy."
      end
    end

	end
end