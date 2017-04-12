module Zorkda
  module Rooms

    class Dropoff < Path

      def initialize(direction)
        super(direction, "there is a short dropoff")
        @plural_description = "there are short dropoffs"
      end
    end

  end
end