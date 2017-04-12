module Zorkda
	module Actors

    #DONE
		class LitBomb < TerrainItem
			attr_accessor :fuse_lit, :moves_when_activated, :moves_to_explode, :damage_link, :damage_enemy

			def initialize(moves_when_activated)
				super("lit bomb", nil, 0)
				@fuse_lit = true
				@moves_to_explode = 2
				@weight = 2
				@breakable = false
				@moves_when_activated = moves_when_activated
				@damage_link = 0.5
				@damage_enemy = 2
				@gen_singular = "lit bomb"
				@gen_plural = "lit bombs"
			end
		end

	end
end