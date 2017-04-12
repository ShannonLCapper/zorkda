module Zorkda
	module Actors

		class InventoryItem < Thing

			attr_accessor :uses, :max_uses, :damage_enemy, :range, :stun_enemy, :gen_singular, :gen_plural,
			:acquired_description, :type, :available_as_child, :available_as_adult, 
			:flammable, :can_throw, :can_shoot, :can_drop, :replace_previous, :quantity_allowed, :display_item,
			:quantity, :parent_alias, :parent_singular, :parent_plural, :can_hit_things

			def initialize(name, gen_singular, gen_plural)
				super()
				@name = name
				@gen_singular = gen_singular
				@gen_plural = gen_plural
				@can_pick_up = true
				@hittable = false
				@damage_enemy = 0
				@range = 0
				@display_item = true
				@acquired_description = nil
				@uses = 1.0/0.0
				@max_uses = 1.0/0.0
				@flammable = false
				@can_drop = false
				@can_throw = false
				@replace_previous = false
				@quantity_allowed = 1
				@quantity = 1
				@parent_alias = false
				@parent_singular = nil
				@parent_plural = nil
				@available_as_adult = true
				@available_as_child = true
				@can_hit_things = false
			end

			def use(game_status, target)
				player = game_status.player

				if player.carrying != nil
					Zorkda::GameOutput.add_line("Your hands are full with something else. Drop that before using any inventory items.")
				elsif self.uses <= 0
					Zorkda::GameOutput.add_line("You are out of #{self.gen_plural}.")
				else
					self.use_item(game_status, target)
				end
			end

			def use_item(game_status, target)
				Zorkda::GameOutput.add_line("The code to use that item has not been written yet.")
			end

			def pick_up(game_status)
				game_status.player.add_to_protagonist(self)
				if self.respawn
					game_status.curr_room.respawn << self
				end
				game_status.curr_room.inventory.delete(self)
			end

		end

	end
end