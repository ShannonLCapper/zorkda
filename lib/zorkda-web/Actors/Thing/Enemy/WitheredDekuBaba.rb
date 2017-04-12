module Zorkda
	module Actors

		#DONE
		class WitheredDekuBaba < Enemy

			def initialize(name, description, distance)
				super(name, "Deku Baba", "Deku Babas", 1, [Zorkda::Actors::DekuStick.new], distance)
				@description = description
				@navi_description = "Though this tall, toothy plant looks withered, it will hurt you if you touch it."
				@respawn = true
				@attack_damage = 0
				@contact_damage = 0.5
				@speed = 0
				@aggression = 0
				@respawn_while_in_room = true
				@respawn_time = 3
				@parent_alias = true
				@parent_singular = "baba"
				@parent_plural = "babas"
				@has_parenthetical_name = true
				@parenthetical_name = "withered"
				@respawn_while_in_room = true
				@respawn_time = 3
			end
		end

	end
end