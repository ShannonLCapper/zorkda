module Zorkda
	module Actors

    #DONE
		class Boots < Equipment
      def initialize(name, weight, available_as_child)
        super(name, "boots", name, name)
        @available_as_child = available_as_child
        @weight = weight
        @parent_alias = true
        @parent_singular = "boot"
        @parent_plural = "boots"
      end
    end

    class KokiriBoots < Boots
      def initialize
        super("Kokiri Boots", 0, true)
        @equipped = true
      end
    end

    class IronBoots < Boots
      def initialize
        super("Iron Boots", 1, true)
        @acquired_description = "So heavy, you can't run. So heavy, you can't float."
      end
    end

	end
end