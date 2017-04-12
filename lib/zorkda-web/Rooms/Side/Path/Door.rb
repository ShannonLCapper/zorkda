module Zorkda
  module Rooms

    class Door < Path

      def initialize(direction)
        super(direction, "there is a door")
        @plural_description = "there are doors"
      end
    end

  end
end