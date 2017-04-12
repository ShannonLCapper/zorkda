module Zorkda
	module Actors

		class DekuStick < InventoryAmmo
			
			def initialize
				super("Deku stick", "Deku stick", "Deku sticks", "stick", 1, 1)
				@parent_alias = true
				@parent_singular = "stick"
				@parent_plural = "sticks"
			end

		end

	end
end