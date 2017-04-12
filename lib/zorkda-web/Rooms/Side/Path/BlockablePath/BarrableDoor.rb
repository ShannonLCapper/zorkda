module Zorkda
  module Rooms

    class BarrableDoor < BlockablePath

			def initialize(direction, blocked)
				super(direction, "there is a barred door", "there is a door", blocked, 
					  "The door is blocked by heavy bars.")
				@blocked_plural_desc = "there are barred doors"
				@unblocked_plural_desc = "there are doors"
				update_plural_desc
			end
		end

  end
end