module Zorkda
	module Actors

		class Hammer < InventoryWeapon
				
			def initialize
				super("Megaton Hammer", "Hammer", "Hammers", 2, 0)
				@type = "hammer"
				@acquired_description = "This heavy hammer can be used to smash and break things! Use it with the commands &quot;hit&quot; and &quot;break&quot;."
				@parent_alias = true
				@parent_singular = "hammer"
				@parent_plural = "hammers"
				@available_as_child = false
			end
		end

	end
end