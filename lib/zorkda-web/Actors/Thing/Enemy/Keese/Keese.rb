module Zorkda
	module Actors

		#DONE
		class Keese < Enemy

			def initialize(name, description)
				super(name, "Keese", "Keese", 1, "RNG", 5)
				@description = description
				@navi_description = "These bats like to fly around and attack. Hit it with " +
														"a ranged weapon if it's far away, or use your sword if " +
														"it's flying at you."
				@stunned_by = []
				@respawn = true
				@attack_damage = 0.5
				@contact_damage = 0.5
				@speed = 3
				@aggression = 2
				@range = 1.0/0.0
				@parent_alias = true
				@parent_singular = "bat"
				@parent_plural = "bats"
			end

			def start_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name} flies toward you.")
				self.attacking = true
				self.distance = 0
				self.moves_when_attack_started = game_status.move_counter
			end

			def land_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name} scratches at your head, then flies away.")
				game_status.player.receive_damage(game_status, self.attack_damage)
				self.terminate_attack
			end

			def terminate_attack
				self.attacking = false
				self.distance = 5
				self.moves_when_attack_started = nil
			end

			def block(game_status)
				Zorkda::GameOutput.add_line("#{self.name} bumps against your shield, then flies away.")
				self.terminate_attack
			end

			def dodge(game_status)
				Zorkda::GameOutput.add_line("#{self.name} dives for you, but you dodge its attack. It flies away.")
				self.terminate_attack
			end
		end

	end
end