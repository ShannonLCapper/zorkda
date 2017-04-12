module Zorkda
	module Rooms

		class Pathway < Path

      def initialize(direction)
        super(direction, "there is a pathway")
        @plural_description = "there are pathways"
      end
    end

	end
end