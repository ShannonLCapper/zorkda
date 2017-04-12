module Zorkda
	module Actors

		class BombBag < InventoryWeapon

			def initialize
				super("Bombs", "bomb", "bombs", 2, 0)
				@type = "bomb"
				@ammo_type = "bombs"
				@acquired_description = "This bomb-holding bag is made from a Dodongo's stomach. 20 bombs are inside. Use bombs with &quot;hit&quot; and &quot;throw&quot;. If not directed at something in particular, bombs explode after 2 moves."
				@uses = 20
				@max_uses = 20
				@can_throw = true
				@can_drop = true
			end

			def use_item(game_status, target)
				move_counter = game_status.move_counter
				player = game_status.player
				curr_room = game_status.curr_room
				if curr_room.underwater
					Zorkda::GameOutput.add_line("You can't use bombs underwater.")
				elsif target == nil
					Zorkda::GameOutput.add_line("You light the fuse on a bomb and throw it.")
					curr_room.inventory << Lit_bomb.new(move_counter)
					self.reduce_uses_left
				elsif target.distance > self.range
					Zorkda::GameOutput.add_line("Your intended target is too far away.")
				elsif target.submerged
					Zorkda::GameOutput.add_line("You can't hit something underwater with a bomb.")
				elsif !target.effective_items.include?("bomb")
					Zorkda::GameOutput.add_line("Your bomb hits the intended target and explodes, but nothing happens.")
					self.reduce_uses_left
				else
					Zorkda::GameOutput.add_line("Your bomb hits the intended target and explodes.")
					target.hit_with_bomb(game_status, self.damage_enemy)
					self.reduce_uses_left
				end
			end
		end

	end
end