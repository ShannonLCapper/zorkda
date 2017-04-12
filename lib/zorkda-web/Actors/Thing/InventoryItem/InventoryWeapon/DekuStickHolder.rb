module Zorkda
	module Actors

	class DekuStickHolder < InventoryWeapon

			attr_accessor :moves_when_lit, :moves_to_burn_out

			def initialize
				super("Deku Sticks", "Deku stick", "Deku sticks", 2, 0)
				@acquired_description = "Deku sticks can be used with the commands &quot;hit&quot;, &quot;break&quot;, and &quot;light&quot;. If your deku stick is on fire, you can put it out with &quot;extinguish stick&quot;."
				@type = "stick"
				@ammo_type = "sticks"
				@parent_alias = true
				@parent_singular = "stick"
				@parent_plural = "sticks"
				@uses = 0
				@max_uses = 10
				@available_as_adult = false
				@flammable = true
				@on_fire = false
				@moves_when_lit = nil
				@moves_to_burn_out = 3
				@display_item = false
			end	

			def use_item(game_status, target)
				player = game_status.player
				curr_room = game_status.curr_room
				stick_used = false
				if target.distance > self.range
					Zorkda::GameOutput.add_line("That target is too far away to hit with a Deku stick.")
				elsif curr_room.underwater || target.submerged
					Zorkda::GameOutput.add_line("You can't use Deku sticks underwater.")
				elsif target.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("You don't have a lot of friends, do you?")
				elsif target.effective_items == nil || (!target.effective_items.include?(self.type) && !target.stunned_by.include?(self.type))
					if target.is_a?(Zorkda::Actors::Enemy)
						Zorkda::GameOutput.add_line("You break your stick in your attack, but the enemy is unaffected.")
					else
						Zorkda::GameOutput.add_line("You break your stick in your wild swinging, but nothing else happens.")
					end
					stick_used = true
				else
					if target.is_a?(Zorkda::Actors::Enemy)
						target.get_hit(game_status, self.type, self.damage_enemy, "You successfully injure the enemy, breaking your stick in the process.")
					elsif target.breakable
						target.break(curr_room, player)
						Zorkda::GameOutput.add_line("But your stick broke too.")
					end
					stick_used = true
				end
				if stick_used
					self.reduce_uses_left
					if self.on_fire
						self.on_fire = false
					end
				end
			end

			def light(move_counter)
				if self.uses <= 0
					Zorkda::GameOutput.add_line("You don't have any Deku sticks left to light.")
				else
					Zorkda::GameOutput.add_line("You light a Deku stick on fire.")
					self.on_fire = true
					self.moves_when_lit = move_counter
				end
			end

			def extinguish
				if !self.on_fire
					Zorkda::GameOutput.add_line("You don't have any lit Deku sticks to extinguish.")
				else
					Zorkda::GameOutput.add_line("You extinguish your lit Deku stick.")
					self.on_fire = false
				end
			end

			def update_lit_deku_stick(move_counter)
				if self.uses > 0 && self.on_fire && 
				move_counter > self.moves_when_lit + self.moves_to_burn_out
					Zorkda::GameOutput.add_line("Your Deku stick burned away.")
					self.reduce_uses_left
					self.on_fire = false
				end
			end

		end

	end
end