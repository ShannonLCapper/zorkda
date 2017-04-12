module Zorkda
  module Actors

    #DONE
    class Medallion < Thing

    	def initialize(name)
    		@name = name
    	end
    end

    class LightMedallion < Medallion

      def initialize
        super("Light Medallion")
      end
    end

    class ForestMedallion < Medallion

      def initialize
        super("Forest Medallion")
      end
    end

    class FireMedallion < Medallion

      def initialize
        super("Fire Medallion")
      end
    end

    class WaterMedallion < Medallion

      def initialize
        super("Water Medallion")
      end
    end

    class ShadowMedallion < Medallion

      def initialize
        super("Shadow Medallion")
      end
    end

    class SpiritMedallion < Medallion

      def initialize
        super("Spirit Medallion")
      end
    end

  end
end