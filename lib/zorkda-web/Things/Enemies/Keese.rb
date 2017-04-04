class Keese < Enemy

	def initialize(name, description)
		super(name, "Keese", "Keese", 1, "RNG", 5)
		@description = description
		@navi_description = "These bats like to fly around and attack.
Hit it with a ranged weapon if it's far away, or use your sword if it's flying at you."
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
		puts "#{self.name} flies toward you."
		self.attacking = true
		self.distance = 0
	end

	def land_attack(game_status)
		puts "#{self.name} scratches at your head, then flies away."
		game_status.player.receive_damage(game_status, self.attack_damage)
		self.terminate_attack
	end

	def terminate_attack
		self.attacking = false
		self.distance = 5
	end

	def block(game_status)
		puts "#{self.name} bumps against your shield, then flies away."
		self.terminate_attack
	end

	def dodge(game_status)
		puts "#{self.name} dives for you, but you dodge its attack. It flies away."
		self.terminate_attack
	end
end

class Fire_keese < Keese

	def initialize(name, description)
		super(name, description)
		@navi_description = "This flying bat is on fire! Destroy it before it flies into you!
If it hits you, your Deku shield could burn away."
		@attack_damage = 1
		@contact_damage = 1
		@on_fire = true
		@on_fire_normally = true
		@has_parenthetical_name = true
		@parenthetical_name = "on fire"
	end

	def land_attack(game_status)
		puts "#{self.name} sets you on fire, then flies away."
		game_status.player.receive_damage(game_status, self.attack_damage)
		game_status.player.on_fire = true
		self.terminate_attack
	end

	def block(game_status)
		game_status.player.equipment.each do |piece|
			if piece.is_a?(Deku_shield)
				if piece.equipped
					puts "You block #{self.name}'s attack but get caught on fire in the process."
					game_status.player.on_fire
					self.terminate_attack
					return
				end
			end
		end
		puts "#{self.name} bumps against your shield, then flies away."
	end

end