class Deku_baba < Enemy

	def initialize(name, description, distance)
		super(name, "Deku Baba", "Deku Babas", 2, [Deku_nuts.new], distance)
		@description = description
		@navi_description = "This tall toothy plant has some attitude.
Hit it when it lungest at you, and it will stand upright. Cut it quickly to get a Deku stick!"
		@respawn = true
		@attack_damage = 0.5
		@contact_damage = 0.5
		@aggression = 5
		@speed = 3
		@parent_alias = true
		@parent_singular = "baba"
		@parent_plural = "babas"
	end

	def start_attack(game_status)
		puts "#{self.name} lunges at you with fangs bared."
		self.attacking = true
		self.stunned_by << "sword"
	end

	def land_attack(game_status)
		puts "#{self.name} sinks its fangs into your arm, then releases you."
		game_status.player.receive_damage(game_status, self.attack_damage)
		self.terminate_attack
	end

	def terminate_attack
		self.attacking = false
		self.stunned_by.delete("sword")
	end

	def stun(move_counter)
		self.stunned = true
		self.moves_when_stunned = move_counter
		self.terminate_attack
		self.contents = [Deku_stick.new]
		puts "#{self.name} freezes upright, stunned."
	end

	def destun
		if self.stunned
			puts "#{self.name} is no longer stunned."
			self.stunned = false
			self.moves_when_stunned = nil
			self.contents = [Deku_nuts.new]
		end
	end

	def block(game_status)
		puts "#{self.name}'s jaws scrape your shield, but you're unharmed."
		self.terminate_attack
	end

	def dodge(game_status)
		puts "#{self.name}'s fangs bite at air as you dodge away from it."
		self.terminate_attack
	end
end