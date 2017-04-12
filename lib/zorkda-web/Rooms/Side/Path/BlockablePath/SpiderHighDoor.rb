module Zorkda
  module Rooms

    class SpiderHighDoor < BlockablePath

			def initialize(direction)
				super(direction, "there is a high door blocked by a Skulltula", 
					  "there is a door set high in the wall", true, 
					  "You try to reach the door, but the Skulltula throws you backward.")
				@blocked_damage = 0.5
				@distance = 1
				@original_distance = 1
				@blocked_plural_desc = "there are high doors blocked by Skulltulas"
				@unblocked_plural_desc = "there are doors set high in the walls"
				update_plural_desc
			end
		end


  end
end