module Zorkda
  module Rooms

    class SpiderLadder < BlockablePath

			def initialize(direction)
				super(direction, "there is a ladder with a skulwalltula crawling on it", 
					  "there is a ladder", true, 
					  "You try to climb the ladder, but you hit the skullwalltula and you're thrown back.")
				@blocked_damage = 0.5
				@blocked_plural_desc = "there are ladders with skullwalltulas crawling on them"
				@unblocked_plural_desc = "there are ladders"
				update_plural_desc
			end
		end

  end
end