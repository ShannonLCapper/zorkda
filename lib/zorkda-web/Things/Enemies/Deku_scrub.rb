class Deku_scrub < Enemy

	attr_accessor :can_hide_from

	def initialize(name, description, distance)
		super(name, "Deku scrub", "Deku scrubs", 1, "RNG", distance)
		@description = description
		@navi_description = "This sneaky plant just hides in the bushes if you try to hit it up close.
Use your shield to bounce back the nuts it spits to force it out of hiding!"
		@effective_items = ["bow", "sword", "stick", "hammer"]
		@can_hide_from = ["sword", "stick", "hammer"]
		@respawn = false
		@attack_damage = 0.5
		@contact_damage = 0
		@speed = 3
		@aggression = 5
		@parent_alias = true
		@parent_singular = "scrub"
		@parent_plural = "scrubs"
		@stunned_by = ["nut", "boomerang", "hookshot", "bomb"]
		@destun_upon_taking_damage = false
		@range = 1
		@destun_time = 3
	end

	def stun(move_counter)
		self.stunned = true
		self.moves_when_stunned = move_counter
		self.effective_items = ["sword", "slingshot", "boomerang", "bow", "bomb", "hookshot", "stick", "hammer"]
		self.stunned_by = []
		self.can_hide_from = []
		puts "#{self.name} jumps out of hiding and runs wildly around. You can attack it up close now."
		if self.attacking
			self.terminate_attack
		end
	end

	def destun
		if self.stunned
			puts "#{self.name} returns to its hiding place."
			self.stunned = false
			self.moves_when_stunned = nil
			self.effective_items = ["bow", "sword", "stick", "hammer"]
			self.stunned_by = ["nut", "boomerang", "hookshot", "bomb"]
			self.can_hide_from = ["sword", "stick", "hammer"]
		end
	end

	def get_hit(game_status, weapon_type, damage_enemy, injure_message)
		curr_room = game_status.curr_room
		move_counter = game_status.move_counter
		if self.effective_items.include?(weapon_type)
			if self.can_hide_from.include?(weapon_type)
				puts "As you approach, #{self.name} ducks into the bushes, making you unable to reach it."
			else
				puts injure_message
				self.receive_damage(game_status, damage_enemy)
			end
		end
		if self.stunned_by.include?(weapon_type) && curr_room.enemies.include?(self)
			self.stun(move_counter)
		end
	end

	def start_attack(game_status)
		puts "#{self.name} shoots a Deku nut at you."
		self.attacking = true
	end

	def land_attack(game_status)
		puts "#{self.name}'s Deku nut smacks you in the face."
		game_status.player.receive_damage(game_status, self.attack_damage)
		self.terminate_attack
	end

	def block(game_status)
		puts "You rebound #{self.name}'s projectile back at it."
		self.stun(game_status.move_counter)
	end

	def dodge(game_status)
		puts "#{self.name}'s Deku nut misses its mark."
		self.terminate_attack
	end

end

class Talking_deku_scrub < Deku_scrub

	attr_accessor :surrender_dialogue

	def initialize(name, description, distance, surrender_dialogue)
		super(name, description, distance)
		@surrender_dialogue = surrender_dialogue
	end

	def get_hit(game_status, weapon_type, damage_enemy, injure_message)
		curr_room = game_status.curr_room
		move_counter = game_status.move_counter
		if self.effective_items.include?(weapon_type)
			if self.can_hide_from.include?(weapon_type)
				puts "As you approach, #{self.name} ducks into the bushes, making you unable to reach it."
			else
				self.surrender
				curr_room.enemies.delete(self)
				curr_room.inventory << Heart.new(nil, nil, false)
			end
		end
		if self.stunned_by.include?(weapon_type) && curr_room.enemies.include?(self)
			self.stun(move_counter)
		end
	end

	def surrender
		print "\n#{self.name}: \""
		stream_dialogue(self.surrender_dialogue)
		puts "\""
		puts "\n"
		puts "And with that, the Deku scrub flees the room, leaving a heart behind." 
	end

end

class Deku_scrub_brother < Deku_scrub

	def initialize(name)
		super(name, nil, 0)
		@destun_time = 1.0/0.0
		@can_hide_from = ["sword", "stick", "hammer", "bow"]
	end

	def stun(move_counter)
		self.stunned = true
		self.moves_when_stunned = move_counter
		self.effective_items = []
		self.stunned_by = []
		self.can_hide_from = []
		if self.attacking
			self.terminate_attack
		end
	end

	def destun
		if self.stunned
			self.stunned = false
			self.moves_when_stunned = nil
			self.effective_items = ["bow", "sword", "stick", "hammer"]
			self.stunned_by = ["nut", "boomerang", "hookshot", "bomb"]
			self.can_hide_from = ["sword", "stick", "hammer"]
		end
	end

	def block(game_status)
		puts "You rebound #{self.name}'s projectile back at it, stunning it in place."
		self.stun(game_status.move_counter)
	end
end