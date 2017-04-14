module Zorkda
	module Actors

		class InventoryAmmo < InventoryItem

			attr_accessor :weapon_type, :spawn_frequency

			def initialize(name, gen_singular, gen_plural, weapon_type, quantity, spawn_frequency)
				super(name, gen_singular, gen_plural)
				@quantity_allowed = 1.0/0.0
				@weapon_type = weapon_type
				@quantity = quantity
				@can_roll_into = true
				@spawn_frequency = spawn_frequency
			end

			def add_to_weapon(inventory)
				item_found = false
				inventory.each do |item|
					if item.type == self.weapon_type
						item_found = true
						unless item.display_item
							Zorkda::GameOutput.add_line(item.acquired_description)
							item.display_item = true
						end
						if item.uses < item.max_uses
							new_val = item.uses + self.quantity
							if new_val < item.max_uses
								item.uses = new_val
							else
								Zorkda::GameOutput.add_line("You now have the maximum number of #{self.gen_plural} you can carry.")
								item.uses = item.max_uses
							end
						end
						break
					end
				end
				if item_found == false
					Zorkda::GameOutput.add_line("But you don't have anything to store #{self.gen_plural} in.")
				end
			end
		end

	end
end