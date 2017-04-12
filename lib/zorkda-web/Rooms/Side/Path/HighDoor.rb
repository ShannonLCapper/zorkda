module Zorkda
  module Rooms

    class HighDoor < Path

      def initialize(direction)
        super(direction, "there is a door set high in the wall")
        @plural_description = "there are doors set high the walls"
        @distance = 1
        @original_distance = 1
      end
    end

  end
end