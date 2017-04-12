module Zorkda
	module Actors

		#DONE
		class Rupee < Thing
			
			attr_accessor :name, :parent_alias, :parent_plural, :parent_singular, :gen_plural, 
			:gen_singular, :value, :description

			def initialize(name, description, respawn)
				super()
				@name = name
				@parent_alias = true
				@parent_plural = "rupees"
				@parent_singular = "rupee"
				@gen_plural = "rupees"
				@gen_singular = "rupee"
				@value = 0
				@distance = 0
				@original_distance = 0
				@weight = 0
				@description = description
				@can_pick_up = true
				@respawn = respawn
				@visible = true
				@hittable = false
				@can_roll_into = true
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