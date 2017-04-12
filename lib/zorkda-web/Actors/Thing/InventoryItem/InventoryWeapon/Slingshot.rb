module Zorkda
	module Actors

	class Slingshot < InventoryWeapon

			def initialize
				super("Fairy Slingshot", "Deku seed", "Deku seeds", 1, 5)
				@acquired_description = "With this weapon, you can shoot deku seeds at distant things using the commands &quot;hit&quot;, &quot;break&quot;, and &quot;shoot&quot;. It came with a seed bag holding 30 deku seeds."
				@type = "slingshot"
				@uses = 30
				@max_uses = 30
				@parent_alias = true
				@ammo_type = "deku seeds"
				@parent_singular = "slingshot"
				@parent_plural = "slingshots"
				@can_shoot = true
				@available_as_adult = false
			end

			def use_item(game_status, target)
				curr_room = game_status.curr_room
				if curr_room.underwater
					Zorkda::GameOutput.add_line("You can't use your slingshot underwater.")
					return
				end
				seed_used = false
				if target.distance > self.range
					Zorkda::GameOutput.add_line("That target is too far away to hit with your slingshot.")
				elsif target.submerged
					Zorkda::GameOutput.add_line("You can't hit something underwater with your slingshot.")
				elsif target.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("Isn't there something more productive you could be doing?")
				elsif target.effective_items == nil || (!target.effective_items.include?(self.type) && !target.stunned_by.include?(self.type))
					if target.is_a?(Zorkda::Actors::Enemy)
						Zorkda::GameOutput.add_line("You fire your slingshot at the enemy, but it doesn't seem to care.")
					else
						Zorkda::GameOutput.add_line("You shoot a Deku seed at the #{target.name}, but nothing happens.")
					end
					seed_used = true
				else
					if target.is_a?(Zorkda::Actors::Enemy)
						target.get_hit(game_status, self.type, self.damage_enemy, "You injure the enemy with your Deku seed projectile.")
					elsif target.breakable
						target.break(curr_room, game_status.player)
					elsif target.hittable
						target.hit(game_status)
					else
						Zorkda::GameOutput.add_line("You shoot a Deku seed at the #{target.name}, but nothing happens.")
					end
					seed_used = true
				end
				if seed_used
					self.reduce_uses_left
				end
			end
			
		end

	end
end