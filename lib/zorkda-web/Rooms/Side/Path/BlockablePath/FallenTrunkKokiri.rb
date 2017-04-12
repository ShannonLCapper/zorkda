module Zorkda
  module Rooms

    class FallenTrunkKokiri < BlockablePath

			def initialize(direction, blocked)
				super(direction, "there is a fallen tree trunk with a path running through it", 
					  "there is a fallen tree trunk with a path running through it", blocked, 
					  "The kokiri stands in front of you, blocking your way.")
				@blocked_plural_desc = "there are fallen tree trunks with paths running through them"
				@unblocked_plural_desc = "there are fallen tree trunks with paths running through them"
				update_plural_desc
			end
		end

  end
end