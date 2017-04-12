module Zorkda
  module Rooms

    class SpiderCubby < BlockablePath

			def initialize(direction)
				super(direction, "there is a cubby blocked by a Skulltula", "there is a cubby", 
					  true, "You try to reach the cubby, but the Skulltula throws you backward.")
				@blocked_damage = 0.5
				@blocked_plural_desc = "there are cubbies blocked by Skulltulas"
				@unblocked_plural_desc = "there are cubbies"
				update_plural_desc
			end
		end

  end
end