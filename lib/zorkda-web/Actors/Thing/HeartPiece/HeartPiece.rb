module Zorkda
	module Actors

		#DONE
		class HeartPiece < Thing

			attr_accessor :name, :gen_plural, :gen_singular, :value, :description, :respawn, :quantity, :quantity_allowed,
			:parent_alias, :parent_singular, :parent_plural

			def initialize(name, description, distance)
				super()
				@gen_plural = "heart pieces"
				@gen_singular = "heart piece"
				if name == nil
					@name = @gen_singular
				else
					@name = name
				end
				@value = 1
				@distance = distance
				@original_distance = distance
				@weight = 0
				@can_pick_up = true
				@can_push = false
				@description = description
				@respawn = false
				@visible = true
				@quantity = 1
				@quantity_allowed = 1.0/0.0
				@parent_alias = false
				@parent_plural = nil
				@parent_singular = nil
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