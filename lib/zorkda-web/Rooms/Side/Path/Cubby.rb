module Zorkda
	module Rooms

		class Cubby < Path

      def initialize(direction)
        super(direction, "there is a cubby")
        @plural_description = "there are cubbies"
      end
    end

	end
end