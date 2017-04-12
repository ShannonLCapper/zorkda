module Zorkda
	module Actors

		class DekuNuts < InventoryAmmo

			def initialize
				super("Deku nuts", "Deku nuts", "Deku nuts", "nut", 5, 3)
				@parent_alias = true
				@parent_singular = "nuts"
				@parent_plural = "nuts"
			end

		end

	end
end