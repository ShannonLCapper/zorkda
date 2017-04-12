module Zorkda
  module Rooms

    class Waterway < Path

      attr_accessor :submerged_distance

      def initialize(direction, submerged_distance)
        super(direction, "there is an underwater passageway")
        @plural_description = "there are underwater passageways"
        @submerged_distance = submerged_distance
      end
    end

  end
end