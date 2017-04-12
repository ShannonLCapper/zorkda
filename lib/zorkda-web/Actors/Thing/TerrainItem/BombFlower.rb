module Zorkda
	module Actors

    #DONE
		class BombFlower < TerrainItem
			attr_accessor :fuse_lit, :moves_when_activated, :moves_to_explode, :damage_link, :damage_enemy, :moves_when_removed

			def initialize(name, description, distance)
				super(name, description, distance)
				@fuse_lit = false
				@moves_to_explode = 3
				@respawn_time = 4
				@drop_name_if_picked_up = true
				@weight = 2
				@breakable = false
				@moves_when_activated = nil
				@moves_when_removed = nil
				@respawn_while_in_room = true
				@damage_link = 0.5
				@damage_enemy = 2
				@gen_singular = "bomb flower"
				@gen_plural = "bomb flowers"
				if @name == nil
					@hame = @gen_singular
				end
			end

		end

	end
end