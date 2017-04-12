module Zorkda
	module Actors

		class InventoryWeapon < InventoryItem

			attr_accessor :ammo_type

			def initialize(name, gen_singular, gen_plural, damage_enemy, range)
				super(name, gen_singular, gen_plural)
				@damage_enemy = damage_enemy
				@range = range
				@ammo_type = nil
				@can_hit_things = true
			end

			def reduce_uses_left
				self.uses -= 1
				if self.uses == 0
					Zorkda::GameOutput.add_line("You are now out of #{self.ammo_type}.")
				end
			end
		end

	end
end