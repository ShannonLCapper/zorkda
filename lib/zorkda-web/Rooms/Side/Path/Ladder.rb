module Zorkda
  module Rooms

    class Ladder < Path

      def initialize(direction)
        super(direction, "there is a ladder")
        @plural_description = "there are ladders"
      end
    end

  end
end