module Zorkda
  module Rooms

    class BlockableWaterPath < BlockablePath

			attr_accessor :submerged_distance

			def initialize(direction, blocked, submerged_distance)
				super(direction, "there is a blocked underwater passageway", 
					  "there is an underwate passageway", blocked, 
					  "You try to go that way, but your path is blocked.")
				@submerged_distance = submerged_distance
				@blocked_plural_desc = "there are blocked underwater passageways"
				@unblocked_plural_desc = "there are underwater passageways"
				update_plural_desc
			end
		end

  end
end