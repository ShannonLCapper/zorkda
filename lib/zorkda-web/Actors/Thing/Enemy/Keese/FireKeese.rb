module Zorkda
	module Actors

		#DONE
		class FireKeese < Keese

			def initialize(name, description)
				super(name, description)
				@navi_description = "This flying bat is on fire! Destroy it before it flies into you! " +
														"If it hits you, your Deku shield could burn away."
				@attack_damage = 1
				@contact_damage = 1
				@on_fire = true
				@on_fire_normally = true
				@has_parenthetical_name = true
				@parenthetical_name = "on fire"
			end

			def land_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name} sets you on fire, then flies away.")
				game_status.player.receive_damage(game_status, self.attack_damage)
				game_status.player.on_fire = true
				self.terminate_attack
			end

			def block(game_status)
				game_status.player.equipment.each do |piece|
					if piece.is_a?(Deku_shield)
						if piece.equipped
							Zorkda::GameOutput.add_line("You block #{self.name}'s attack but get caught on fire in the process.")
							game_status.player.on_fire
							self.terminate_attack
							return
						end
					end
				end
				Zorkda::GameOutput.add_line("#{self.name} bumps against your shield, then flies away.")
			end

		end

	end
end