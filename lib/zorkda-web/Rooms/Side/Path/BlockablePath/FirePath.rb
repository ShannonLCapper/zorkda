module Zorkda
  module Rooms

    class FirePath < BlockablePath

			def initialize(direction, blocked)
				super(direction, "there is a path blocked by a pillar of fire", "there is a path", blocked, 
					  "You try to pass through the fire, but you get thrown back. Say goodbye to your eyebrows.")
				@blocked_damage = 0.5
				@on_fire = true
				@blocked_plural_desc = "there are paths blocked by pillars of fire"
				@unblocked_plural_desc = "there are paths"
				update_plural_desc
			end
		end

  end
end