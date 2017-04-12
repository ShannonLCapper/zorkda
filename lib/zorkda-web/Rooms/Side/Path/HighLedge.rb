module Zorkda
  module Rooms

    class HighLedge < Path

      def initialize(direction)
        super(direction, "there is a high ledge")
        @plural_description = "there are high ledges"
        @distance = 1
        @original_distance = 1
      end
    end

  end
end