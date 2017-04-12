module Zorkda
  module Rooms

    class SpiderHighCubby < BlockablePath

			def initialize(direction)
				super(direction, "there is a high cubby blocked by a Skulltula", "there is a high cubby", 
					  true, "You try to reach the cubby, but the Skulltula throws you backward.")
				@blocked_damage = 0.5
				@distance = 1
				@original_distance = 1
				@blocked_plural_desc = "there are high cubbies blocked by Skulltulas"
				@unblocked_plural_desc = "there are high cubbies"
				update_plural_desc
			end
		end

  end
end