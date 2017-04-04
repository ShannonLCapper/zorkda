class Gohma_egg < Enemy

	attr_accessor :moves_to_hatch

	def initialize(name, description, distance)
		super(name, "Gohma egg", "Gohma eggs", 1, "RNG", distance)
		@stunned_by = []
		@description = description
		@navi_description = "Better dispose of this egg before it hatches!"
		@attack_damage = 0
		@contact_damage = 0.5
		@aggression = 0
		@speed = 0
		@moves_to_hatch = 3
		@parent_alias = true
		@parent_singular = "egg"
		@parent_plural = "eggs"
	end

	def update(game_status)
		if self.moves_to_hatch == 0
			self.hatch(game_status)
		else
			self.moves_to_hatch -= 1
		end
	end

	def hatch(game_status)
		curr_room = game_status.curr_room
		enemy_index = curr_room.enemies.index(self)
		curr_room.enemies.delete(self)
		curr_room.enemies.insert(enemy_index, Gohma_larva.new(nil, nil, self.distance))
		puts "#{self.name} hatched into a Gohma larva."
	end

	def die(curr_room, player, move_counter)
		self.dead = true
		print "#{self.name} dies"
		if self.contents != nil && self.contents.length > 0
			print ", giving you the following: "
			(self.contents.length - 1).times do |i|
				print self.contents[i].name
				if self.contents.length > 2
					print ", "
				else
					print " "
				end
			end
			if self.contents.length > 1
				print "and "
			end
			puts "#{self.contents.last.name}"
			self.contents.each do |item|
				player.add_to_protagonist(item)
			end
		else
			puts "."
		end
		self.terminate_attack
		self.moves_to_hatch = 3
		self.health = self.health_max
		self.stunned = false
		self.moves_when_stunned = nil
		self.dead = false
		if self.respawn_while_in_room
			self.moves_when_removed = move_counter
			curr_room.respawn_while_in_room << self
		elsif self.respawn
			curr_room.respawn << self
		end
		curr_room.enemies.delete(self)
	end
end

class Gohma_larva < Enemy

	def initialize(name, description, distance)
		super(name, "Gohma larva", "Gohma larvae", 2, [Deku_seeds.new], distance)
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
		puts "#{self.name}'s eye turns red, and it pounces at you."
		self.attacking = true
	end

	def land_attack(game_status)
		puts "#{self.name} pounces on you, then jumps off."
		game_status.player.receive_damage(game_status, self.attack_damage)
		self.terminate_attack
	end

	def block(game_status)
		puts "#{self.name} bounces harmlessly off your shield."
		self.terminate_attack
	end

	def dodge(game_status)
		puts "#{self.name} leaps for you and misses."
		self.terminate_attack
	end
end