module Zorkda
  module Rooms

    class LockableDoor < BlockablePath

			def initialize(direction)
				super(direction, "there is a locked door", "there is a door", 
					  true, "You try to open the door, but it's locked.")
				@blocked_plural_desc = "there are locked doors"
				@unblocked_plural_desc = "there are doors"
				update_plural_desc
			end
		end

  end
end