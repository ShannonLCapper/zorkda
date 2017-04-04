class Gohma < Enemy

	def initialize
		super("Gohma", "Gohma", "Gohmas", 8, [], 5)
		@stunned_by = []
		@effective_items = ["sword", "stick"]
		@description = "You can see the giant parasitic arachnid Gohma crawling around the ceiling."
		@parent_alias = true
		@parent_singular = "spider"
		@parent_plural = "spiders"
		@navi_description = "This giant, cycloptic spider is one of the parasitic monsters inside the Deku Tree!
It's vulnerable when its eye turns red."
		@respawn = false
		@attack_damage = 0
		@contact_damage = 0
		@speed = 0
		@range = 1.0/0.0
		@aggression = 6
		@destun_upon_taking_damage = false
		@destun_time = 3
	end

	def determine_if_attacking(game_status)
		if self.attacking
			self.land_attack(game_status)
		end
		if !self.attacking && !self.stunned && game_status.curr_room.enemies.length == 1
			random_number = rand(1..10)
			if random_number <= self.aggression
				self.start_attack(game_status)
			end
		end
	end

	def start_attack(game_status)
		puts "Gohma's eye turns red."
		self.attacking = true
		self.stunned_by = ["slingshot"]
	end

	def land_attack(game_status)
		puts "Gohma lays two eggs, which fall to the ground in front of you."
		2.times { game_status.curr_room.enemies << Gohma_egg.new(nil, nil, 0) }
		self.terminate_attack
	end

	def terminate_attack
		self.attacking = false
		self.stunned_by = []
	end

	def stun(move_counter)
		puts "The Deku seed hits Gohma in the eye, and she crashes to the ground, stunned."
		self.description = "Gohma lays stunned on the ground."
		self.distance = 0
		self.stunned = true
		self.moves_when_stunned = move_counter
		self.terminate_attack
	end

	def destun
		if self.stunned
			puts "Gohma recovers, crawling back to the ceiling."
			self.description = "You can see the giant parasitic arachnid Gohma crawling around the ceiling."
			self.stunned = false
			self.moves_when_stunned = nil
			self.distance = 5
		end
	end

	def block(game_status)
		puts "You raise your shield, but Gohma does not attack you."
	end	

	def dodge(game_status)
		puts "You dodge, but Gohma does not try to attack you."
	end

	def receive_damage(game_status, damage)
		if !self.awake
			puts "#{self.name} woke up!"
			self.awake = true
		end
		enemy_removed = false
		player = game_status.player
		curr_room = game_status.curr_room
		move_counter = game_status.move_counter
		if self.health <= damage
			self.die(game_status)
			enemy_removed = true
		else
			self.health -= damage
		end
		return enemy_removed
	end

	def die(game_status)
		curr_room = game_status.curr_room
		player = game_status.player
		curr_room.enemies = []
		curr_room.inventory << Heart_container.new(nil, "A heart container lies in the center of the room.", 0)
		game_status.checkpoint += 1
		curr_room.contains_portal = true
		curr_room.portal_goes_to = game_status.child_rooms[:kf_deku_glen]
		death_scene = "\n\nGohma flails wildly, then falls to the ground dead.
Her body disintegrates in bursts of blue flame.
A heart container lies glistening where her body lay.

In the center of the room, a glowing blue portal appears.

Navi: \"Good job, #{player.name}! Get that heart container and let's get out of here!
You can enter that portal by typing \"enter portal\".\""
		stream_dialogue(death_scene)
		puts "\n"
	end
end