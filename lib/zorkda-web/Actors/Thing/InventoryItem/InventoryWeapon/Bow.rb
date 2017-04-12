module Zorkda
	module Actors

		class Bow < InventoryWeapon
				
			def initialize
				super("Fairy Bow", "arrow", "arrows", 2, 10)
				@type = "bow"
				@acquired_description = "With this weapon, you can shoot arrows at distant things using the commands &quot;hit&quot;, &quot;break&quot;, and &quot;shoot&quot;. It came with a quiver holding 30 arrows."
				@ammo_type = "arrows"
				@uses = 30
				@max_uses = 30 
				@parent_alias = true
				@parent_singular = "bow"
				@parent_plural = "bows"
				@can_shoot = true
				@available_as_child = false
			end

		end

    class FireArrows < InventoryWeapon

    end

    class IceArrows < InventoryWeapon

    end

	end
end