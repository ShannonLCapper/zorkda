module Zorkda
	module Actors

		#DONE
		class Enemy < Thing
			attr_accessor :name, :description, :gen_singular, :gen_plural, :parent_alias, :parent_singular, 
			:parent_plural, :stunned_by, :stunned, :moves_when_stunned, :destun_time, :contents, :respawn,
			:respawn_while_in_room, :moves_when_removed,  :contact_damage, :effective_items, :health, :health_max, 
			:navi_description, :awake, :on_fire, :frozen, :on_fire_normally, :speed, :aggression, 
			:destun_upon_taking_damage, :random_contents, :awake_normally, :attacking, :attack_damage,
			:range, :dead, :moves_when_attack_started, :moves_to_land_attack

			def initialize(name, gen_singular, gen_plural, health, contents, distance)
				#set when initialized
				super()
				if name == nil
					@name = gen_singular
				else
					@name = name
				end
				@distance = distance
				@original_distance = distance
				@gen_singular = gen_singular
				@gen_plural = gen_plural
				@health = health
				@health_max = health
				@effective_items = ["sword", "slingshot", "boomerang", "bow", "bomb", "hookshot", "stick", "hammer"]
				if contents.is_a?(String) && contents.upcase == "RNG"
					@random_contents = true
					@contents = nil
				else
					@contents = contents
				end

				#unique to each enemy
				@description = nil
				@navi_description = "This is an enemy."
				@respawn = true
				@attack_damage = 0.5
				@contact_damage = 0.5
				@speed = 3
				@aggression = 5

				#most enemies have the same
				@stunned_by = ["hookshot", "nut", "boomerang"]
				@respawn_while_in_room = false
				@respawn_time = 1.0/0.0
				@awake = true
				@awake_normally = true
				@on_fire_normally = false
				@on_fire = false
				@frozen = false
				@destun_upon_taking_damage = true
				@range = 0
				@destun_time = 2
				@moves_to_land_attack = 1

				#never changes at initialization
				@stunned = false
				@moves_when_stunned = nil
				@moves_when_removed = nil
				@attacking = false
				@moves_when_attack_started = nil
				@dead = false
			end

			def update(game_status)
				self.check_if_destun(game_status.move_counter)
				self.determine_if_attacking(game_status)
			end

			def determine_if_attacking(game_status)
				if self.attacking && self.distance > self.range
					self.terminate_attack
				elsif self.attacking && 
							self.distance <= self.range &&
							self.moves_when_attack_started + self.moves_to_land_attack <= game_status.move_counter
					self.land_attack(game_status)
				end
				if !self.attacking && !self.stunned && self.distance <= self.range
					random_number = rand(1..10)
					if random_number <= self.aggression
						self.start_attack(game_status)
					end
				end
			end

			def start_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name} starts its attack.")
				self.attacking = true
				self.moves_when_attack_started = game_status.move_counter
			end

			def land_attack(game_status)
				Zorkda::GameOutput.add_line("#{self.name} lands its attack.")
				game_status.player.receive_damage(game_status, self.attack_damage)
				self.terminate_attack
			end

			def terminate_attack
				self.attacking = false
				self.moves_when_attack_started = nil
			end

			def stun(move_counter)
				self.stunned = true
				self.moves_when_stunned = move_counter
				self.terminate_attack
				if self.on_fire
					self.on_fire = false
				end
				Zorkda::GameOutput.add_line("#{self.name} has been stunned.")
			end

			def check_if_destun(move_counter)
				if self.stunned && move_counter > self.moves_when_stunned + self.destun_time
					self.destun
				end
			end

			def destun
				if self.stunned
					Zorkda::GameOutput.add_line("#{self.name} is no longer stunned.")
					self.stunned = false
					self.moves_when_stunned = nil
					if self.on_fire_normally
						self.on_fire = true
					end
				end
			end

			def dodge(game_status)
				Zorkda::GameOutput.add_line("You dodge #{self.name}'s attack.")
				self.terminate_attack
			end

			def block(game_status)
				Zorkda::GameOutput.add_line("You successfully block #{self.name}'s attack.")
				self.terminate_attack
			end

			def get_hit(game_status, weapon_type, damage_enemy, injure_message)
				curr_room = game_status.curr_room
				move_counter = game_status.move_counter
				if self.effective_items.include?(weapon_type)
					Zorkda::GameOutput.add_line(injure_message)
					self.receive_damage(game_status, damage_enemy)
				end
				if self.stunned_by.include?(weapon_type) && curr_room.enemies.include?(self)
					self.stun(move_counter)
				end
				if self.attacking
					random_number = rand(1..10)
					if random_number > self.speed
						self.terminate_attack
					end
				end
			end

			def receive_damage(game_status, damage)
				if !self.awake
					Zorkda::GameOutput.add_line("#{self.name} woke up!")
					self.awake = true
				end
				enemy_removed = false
				player = game_status.player
				curr_room = game_status.curr_room
				move_counter = game_status.move_counter
				if self.health <= damage
					self.die(curr_room, player, move_counter)
					enemy_removed = true
				else
					self.health -= damage
				end
				return enemy_removed
			end

			def die(curr_room, player, move_counter)
				self.dead = true
				text = "#{self.name} dies"
				if self.contents.nil? || self.contents.empty?
					text += "."
					Zorkda::GameOutput.add_line(text)
				else
					text += ", giving you the following: "
					(self.contents.length - 1).times do |i|
            separator = self.contents.length > 2 ? ", " : " "
            text += self.contents[i].name + separator
          end
          text += "and " if self.contents.length > 1
          text += "#{self.contents.last.name}"
					Zorkda::GameOutput.add_line(text)
					self.contents.each do |item|
						player.add_to_protagonist(item)
					end
				end
				self.terminate_attack
				self.health = self.health_max
				self.stunned = false
				self.moves_when_stunned = nil
				if self.on_fire_normally
					self.on_fire = true
				end
				if !self.awake_normally
					self.awake = false
				end
				self.dead = false
				if self.respawn_while_in_room
					self.moves_when_removed = move_counter
					curr_room.respawn_while_in_room << self
				elsif self.respawn
					curr_room.respawn << self
				end
				curr_room.enemies.delete(self)
			end

			def hit_with_bomb(game_status, damage)
				if !self.awake
					Zorkda::GameOutput.add_line("#{self.name} woke up!")
					self.awake = true
				end
				enemy_removed = false
				bomb_connects = false
				if self.effective_items.include?("bomb") && !self.submerged
					enemy_removed = self.receive_damage(game_status, damage)
					if !enemy_removed
						Zorkda::GameOutput.add_line("#{self.name} is injured by the explosion.")
					end
					bomb_connects = true
				elsif self.stunned_by.include?("bomb") && !self.submerged
					self.stun(game_status.move_counter)
					bomb_connects = true
				end
				if self.attacking && bomb_connects
					random_number = rand(1..10)
					if random_number > self.speed
						self.terminate_attack
					end
				end
				return enemy_removed
			end

			def touch(game_status)
				player = game_status.player
				if !self.awake
					Zorkda::GameOutput.add_line("#{self.name} woke up!")
					self.awake = true
				elsif !self.stunned && self.contact_damage != nil && self.contact_damage > 0
					player.receive_damage(game_status, self.contact_damage)
				end
				if self.on_fire
					player.on_fire = true
				elsif self.frozen
					player.freeze(game_status.move_counter)
				end
			end
		end

	end
end
