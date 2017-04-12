module Zorkda
	module Actors

		#DONE
		class GohmaLarva < Enemy

			def initialize(name, description, distance)
				super(name, "Gohma larva", "Gohma larvae", 2, [Zorkda::Actors::DekuSeeds.new], distance)
				@description = description
				@navi_description = "This one-eyed monster spawn likes to pounce, so look out!"
				@contact_damage = 0.5
				@attack_damage = 0.5
				@aggression = 3
				@speed = 3
				@respawn = false
				@parent_alias = true
				@parent_singular = "larva"
				@parent_plural = "larvae"
			end

			def start_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name}'s eye turns red, and it pounces at you.")
				self.attacking = true
				self.moves_when_attack_started = game_status.move_counter
			end

			def land_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name} pounces on you, then jumps off.")
				game_status.player.receive_damage(game_status, self.attack_damage)
				self.terminate_attack
			end

			def block(game_status)
				Zorkda::GameOutput.add_line("#{self.name} bounces harmlessly off your shield.")
				self.terminate_attack
			end

			def dodge(game_status)
				Zorkda::GameOutput.add_line("#{self.name} leaps for you and misses.")
				self.terminate_attack
			end
		end

	end
end