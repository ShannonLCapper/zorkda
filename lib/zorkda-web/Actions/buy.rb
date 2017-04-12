module Zorkda
	module Actions

		def self.buy(game_status, obj)
			curr_room = game_status.curr_room
			player = game_status.player
			shopkeeper_present = false
			shopkeeper = nil
			curr_room.characters.each do |person|
				if person.is_a?(Zorkda::Actors::Shopkeeper)
					shopkeeper = person
					shopkeeper_present = true
				end
			end
			if shopkeeper_present == false
				Zorkda::GameOutput.add_line("There's no one here that has things for sale.")
				return
			else
				matches = self::Utils.find_matches(shopkeeper.wares, obj)
				if matches.length == 0
					shopkeeper.item_not_found_dialogue
				elsif matches.length > 1
					Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to buy.")
					self::Utils.list_options(matches)
					Zorkda::GameOutput.add_line("Type &quot;buy&quot; and the item you want.")
				else
					ware = matches[0]
					if ware.inventory_quantity == 0
						shopkeeper.sold_out_dialogue(ware)
						return
					elsif player.rupees_curr < ware.price
						shopkeeper.cant_afford_dialogue
						return
					elsif ware.adult_only && player.age == "child"
						Zorkda::GameOutput.add_line("Only adults can buy that item.")
						return
					elsif ware.child_only && player.age == "adult"
						Zorkda::GameOutput.add_line("You seem a little too old to be buying something like that.")
						return
					elsif ware.item.is_a?(Zorkda::Actors::Equipment)
						matches = []
						player.equipment.each do |equipment_item|
							if equipment_item.class.name.split('::').last == ware.item.class.name.split('::').last
								matches << equipment_item
							end
						end
						if matches.length >= ware.item.quantity_allowed
							Zorkda::GameOutput.add_line("You can't store any more of that type of item.")
							return
						end
					elsif ware.item.is_a?(Zorkda::Actors::InventoryAmmo)
						matches = []
						player.inventory.each do |inventory_item|
							if inventory_item.is_a?(Zorkda::Actors::InventoryWeapon) && inventory_item.type == ware.item.weapon_type
								matches << inventory_item
								if inventory_item.max_uses == inventory_item.uses
									Zorkda::GameOutput.add_line("You can't carry any more of those.")
									return
								end
								break
							end
						end
						if matches.length == 0
							Zorkda::GameOutput.add_line("You don't have any way of storing those.")
							return
						end
					elsif ware.item.is_a?(Zorkda::Actors::InventoryItem)
						matches = []
						player.inventory.each do |inv_item|
							if inv_item.class.name.split('::').last == ware.class.name.split('::').last
								matches << inv_item
							end
						end
						if matches.length >= inv_item.quantity_allowed
							Zorkda::GameOutput.add_line("You can't store any more of that type of item.")
							return
						end
					end
					Zorkda::GameOutput.add_line("You cough up #{ware.price} ")
					word = ware.price == 1 ? "rupee" : "rupees"
					Zorkda::GameOutput.append_text("#{word} for the #{ware.name}.")
					player.lose_rupees(ware.price)
					shopkeeper.take_ware(ware)
					ware.quantity_per_sale.times do
						player.add_to_protagonist(ware.item)
					end
				end
			end
		end

	end
end