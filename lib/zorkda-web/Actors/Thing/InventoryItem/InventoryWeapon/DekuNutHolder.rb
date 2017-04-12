module Zorkda
	module Actors

	class DekuNutHolder < InventoryWeapon

			def initialize
				super("Deku Nuts", "Deku nut", "Deku nuts", 0, 0)
				@acquired_description = "Deku nuts can be used to stun enemies. Use them with the commands &quot;hit&quot; and &quot;throw&quot;."
				@type = "nut"
				@ammo_type = "nuts"
				@parent_alias = true
				@parent_singular = "nut"
				@parent_plural = "nuts"
				@uses = 0
				@max_uses = 20
				@can_throw = true
				@display_item = false
			end

			def use_item(game_status, target)
				move_counter = game_status.move_counter
				curr_room = game_status.curr_room
				nut_used = false
				#no single target
				if target == nil
					if curr_room.underwater
						Zorkda::GameOutput.add_line("You can't use Deku nuts underwater.")
						return
					end
					nut_used = true
					if curr_room.enemies.length == 0
						Zorkda::GameOutput.add_line("You throw a Deku nut with a flash, but there is no effect.")
					else 
						enemies_in_range = []
						enemy_in_range = false
						curr_room.enemies.each do |enemy|
							if enemy.distance <= self.range && !enemy.submerged
								enemies_in_range << enemy
								enemy_in_range = true
							end
						end
						if enemies_in_range.length == 0
							Zorkda::GameOutput.add_line("You throw a Deku nut, but no enemies are in range.")
						else
							enemy_hit = false
							enemies_in_range.each do |enemy|
								if enemy.distance <= self.range && enemy.stunned_by.include?(self.type)
									enemy.stun(move_counter)
									enemy_hit = true
								end
							end
							if enemy_hit == false
								Zorkda::GameOutput.add_line("You throw a Deku nut, but no enemies were affected.")
							end
						end
					end
				#throw at single target
				else
					if target.distance > self.range
						Zorkda::GameOutput.add_line("That target is too far away to hit with a Deku nut.")
					elsif target.submerged
						Zorkda::GameOutput.add_line("You can't hit something underwater with a Deku nut.")
					elsif target.is_a?(Zorkda::Actors::Character)
						Zorkda::GameOutput.add_line("Why don't you use your roguish good looks to stun people instead?")
					elsif target.is_a?(Zorkda::Actors::Enemy) && target.stunned_by.include?(self.type)
						target.stun(move_counter)
						nut_used = true
					else
						Zorkda::GameOutput.add_line("You throw a Deku nut with a flash, but nothing happens.")
						nut_used = true
					end
				end
				if nut_used
					self.reduce_uses_left
				end
			end

		end

	end
end