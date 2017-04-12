module Zorkda
  module Rooms

    class SpiderVines < BlockablePath

			def initialize(direction)
				super(direction, "there are vines with a skullwalltula crawling on them", 
					  "there are some vines", true, 
					  "You try to climb the vines, but you hit the skullwalltula and you're thrown back.")
				@blocked_damage = 0.5
				@blocked_plural_desc = "there are vines with skullwalltulas crawling on them"
				@unblocked_plural_desc = "there are vines"
				update_plural_desc
			end
		end

  end
end