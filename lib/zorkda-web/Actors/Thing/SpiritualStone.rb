module Zorkda
  module Actors

    #DONE
    class SpiritualStone < Thing

    	def initialize(name)
    		@name = name
    	end
    end

    class KokiriEmerald < SpiritualStone

      def initialize
        super("Kokiri's Emerald")
      end
    end

    class GoronRuby < SpiritualStone
      
      def initialize
        super("Goron's Ruby")
      end
    end

    class ZoraSapphire < SpiritualStone

      def initialize
        super("Zora's Sapphire")
      end
    end

  end
end