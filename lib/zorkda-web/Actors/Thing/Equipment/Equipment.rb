module Zorkda
	module Actors

		#DONE
		class Equipment < Thing
			attr_accessor :name, :equipped, :type, :damage_enemy, :gen_singular, :gen_plural, :range, 
			:available_as_child, :available_as_adult, :parent_alias, :parent_singular,
			:parent_plural, :replace_previous, :description, :can_pick_up, :can_slide, 
			:flammable, :hookshotable, :rewspawn, :acquired_description, :susceptible_to_fire,
			:reflective, :strength, :weight, :heat_resistance, :underwater_breathing, 
			:diving_distance, :quantity_allowed, :quantity, :can_roll_into,
			:can_hit_things, :can_shoot

			def initialize(name, type, gen_singular, gen_plural)
				super()
				@name = name
				@equipped = false
				@type = type
				@damage_enemy = 0
				@gen_singular = gen_singular
				@gen_plural = gen_plural
				@range = 0
				@available_as_child = true
				@available_as_adult = true
				@parent_alias = false
				@parent_singular = nil
				@parent_plural = nil
				@replace_previous = false
				@description = nil
				@can_pick_up = true
				@can_slide = false
				@flammable = false
				@hookshotable = false
				@respawn = false
				@acquired_description = nil
				@susceptible_to_fire = false
				@reflective = false
				@strength = 0
				@weight = 0
				@heat_resistance = 0
				@underwater_breathing = 0
				@diving_distance = 0
				@quantity_allowed = 1
				@quantity = 1
				@can_roll_into = true
				@can_hit_things = false
				@can_shoot = false
			end

			def use
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