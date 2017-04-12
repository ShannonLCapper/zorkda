module Zorkda
	module Rooms

		class Opening < Path
      def initialize(direction)
        super(direction, "there is an opening")
        @plural_description = "there are openings"
      end
    end

	end
end