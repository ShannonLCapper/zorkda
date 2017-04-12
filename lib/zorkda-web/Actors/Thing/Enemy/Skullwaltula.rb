module Zorkda
	module Actors

		#DONE
		class Skullwalltula < Enemy

			def initialize(name, description, distance)
				super(name, "Skullwalltula", "Skullwalltulas", 1, "RNG", distance)
				@description = description
				@navi_description = "This nasty spider likes to cling to walls. Be careful not to touch it!"
				@respawn = false
				@attack_damage = 0
				@contact_damage = 0.5
				@speed = 0
				@aggression = 0
				@parent_alias = true
				@parent_singular = "spider"
				@parent_plural = "spiders"
			end
		end

	end
end