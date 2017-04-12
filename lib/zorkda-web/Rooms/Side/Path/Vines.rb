module Zorkda
  module Rooms

    class Vines < Path

      def initialize(direction)
        super(direction, "there are some vines")
        @plural_description = "there are vines"
      end
    end

  end
end