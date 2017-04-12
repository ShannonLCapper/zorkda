module Zorkda
  module Rooms

    class BreakableSide < BlockablePath

			def initialize(direction)
				super(direction, "there is a wall that looks a little fragile", 
					  "there is an opening", true, "The wall seems crumbly, but it's still a wall.")
				@blocked_plural_desc = "there are walls that look rather fragile"
				@unblocked_plural_desc = "there are openings"
				update_plural_desc
			end
		end

  end
end