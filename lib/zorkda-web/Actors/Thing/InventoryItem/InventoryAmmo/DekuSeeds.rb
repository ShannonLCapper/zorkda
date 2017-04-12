module Zorkda
	module Actors

		class DekuSeeds < InventoryAmmo

			def initialize
				super("Deku seeds", "Deku seeds", "Deku seeds", "slingshot", 5, 4)
				@parent_alias = true
				@parent_singular = "seeds"
				@parent_plural = "seeds"
			end
		end

	end
end