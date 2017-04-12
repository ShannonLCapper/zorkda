module Zorkda
  module Rooms

    class SpiderDoor < BlockablePath

			def initialize(direction)
				super(direction, "there is a door blocked by a Skulltula", "there is a door", 
					  true, "You try to reach the door, but the Skulltula throws you backward.")
				@blocked_damage = 0.5
				@blocked_plural_desc = "there are doors blocked by Skulltulas"
				@unblocked_plural_desc = "there are doors"
				update_plural_desc
			end
		end

  end
end