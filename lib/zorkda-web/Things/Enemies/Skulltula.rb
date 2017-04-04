class Skulltula < Enemy

	attr_accessor :moves_when_last_spun

	def initialize(name, description, distance)
		super(name, "Skulltula", "Skulltulas", 2, "RNG", distance)
		@description = description
		@navi_description = "This nasty spider likes to hang down from the ceiling.
Its soft backside is its weak point!"
		@respawn = true
		@attack_damage = 0
		@contact_damage = 0.5
		@speed = 0
		@aggression = 5
		@effective_items = ["hookshot", "bow", "bomb", "hammer"]
		@moves_when_last_spun = 0
		@parent_alias = true
		@parent_singular = "spider"
		@parent_plural = "spiders"
	end

	def determine_if_attacking(game_status)
		if self.attacking && self.distance > self.range
			self.terminate_attack
		elsif self.attacking && self.distance <= self.range
			self.land_attack(game_status)
		elsif !self.attacking && !self.stunned && self.distance <= self.range && 
		game_status.move_counter > 1 + moves_when_last_spun 
			random_number = rand(1..10)
			if random_number <= self.aggression
				self.start_attack(game_status)
			end
		end
	end

	def start_attack(game_status)
		puts "#{self.name} spins around, exposing its belly."
		self.attacking = true
		self.effective_items = ["sword", "slingshot", "boomerang", "bow", "bomb", "hookshot", "stick", "hammer"]
		self.moves_when_last_spun = game_status.move_counter
	end

	def land_attack(game_status)
		puts "#{self.name} spins back around to face you."
		self.terminate_attack
	end

	def terminate_attack
		self.attacking = false
		self.effective_items = ["hookshot", "bow", "bomb", "hammer"]
	end

	def stun(move_counter)
		puts "#{self.name} is now stunned."
		self.stunned = true
		self.moves_when_stunned = move_counter
	end

	def block(game_status)
		puts "You raise your shield, but #{self.name} doesn't strike."
	end

	def dodge(game_status)
		puts "You leap away from #{self.name}, but it does not try to strike."
	end

	def get_hit(game_status, weapon_type, damage_enemy, injure_message)
		curr_room = game_status.curr_room
		move_counter = game_status.move_counter
		if self.effective_items.include?(weapon_type)
			puts injure_message
			is_dead = self.receive_damage(game_status, damage_enemy)
			if !is_dead
				self.land_attack(game_status)
			end
		end
		if self.stunned_by.include?(weapon_type) && curr_room.enemies.include?(self)
			self.stun(move_counter)
		end
	end
end
