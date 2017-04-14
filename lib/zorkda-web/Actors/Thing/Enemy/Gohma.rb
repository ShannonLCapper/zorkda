module Zorkda
	module Actors

		#DONE
		class Gohma < Enemy

			def initialize
				super("Gohma", "Gohma", "Gohmas", 6, [], 5)
				@stunned_by = []
				@effective_items = ["sword", "stick"]
				@description = "You can see the giant parasitic arachnid Gohma crawling around the ceiling."
				@parent_alias = true
				@parent_singular = "spider"
				@parent_plural = "spiders"
				@navi_description = "This giant, cycloptic spider is one of the parasitic monsters inside the Deku Tree! " +
														"It's vulnerable when its eye turns red."
				@respawn = false
				@attack_damage = 0
				@contact_damage = 0
				@speed = 0
				@range = 1.0/0.0
				@aggression = 6
				@destun_upon_taking_damage = false
				@destun_time = 2
			end

			def determine_if_attacking(game_status)
				if self.attacking &&
					self.moves_when_attack_started + self.moves_to_land_attack <= game_status.move_counter
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
				Zorkda::GameOutput.add_line("Gohma's eye turns red.")
				self.attacking = true
				self.stunned_by = ["slingshot"]
				self.moves_when_attack_started = game_status.move_counter
			end

			def land_attack(game_status)
				Zorkda::GameOutput.add_line("Gohma lays two eggs, which fall to the ground in front of you.")
				2.times { game_status.curr_room.enemies << Zorkda::Actors::GohmaEgg.new(nil, nil, 0) }
				self.terminate_attack
			end

			def terminate_attack
				self.attacking = false
				self.stunned_by = []
				self.moves_when_attack_started = nil
			end

			def stun(move_counter)
				Zorkda::GameOutput.add_line("The Deku seed hits Gohma in the eye, and she crashes to the ground, stunned.")
				self.description = "Gohma lays stunned on the ground."
				self.distance = 0
				self.stunned = true
				self.moves_when_stunned = move_counter
				self.terminate_attack
			end

			def destun
				if self.stunned
					Zorkda::GameOutput.add_line("Gohma recovers, crawling back to the ceiling.")
					self.description = "You can see the giant parasitic arachnid Gohma crawling around the ceiling."
					self.stunned = false
					self.moves_when_stunned = nil
					self.distance = 5
				end
			end

			def block(game_status)
				Zorkda::GameOutput.add_line("You raise your shield, but Gohma does not attack you.")
			end	

			def dodge(game_status)
				Zorkda::GameOutput.add_line("You dodge, but Gohma does not try to attack you.")
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
				curr_room.inventory << Zorkda::Actors::HeartContainer.new(nil, "A heart container lies in the center of the room.", 0)
				game_status.checkpoint += 1
				curr_room.contains_portal = true
				curr_room.portal_goes_to = game_status.child_rooms[:kf_deku_glen]
				Zorkda::GameOutput.new_paragraph
				death_text = [
					"Gohma flails wildly, then falls to the ground dead. " +
					"Her body disintegrates in bursts of blue flame. " +
					"A heart container lies glistening where her body lay.",
					" ",
					"In the center of the room, a glowing blue portal appears.",
					" ",
					"Navi: &quot;Good job, #{player.name}! Get that heart container and let's get out of here! " +
					"You can enter that portal by typing &quot;enter portal&quot;.&quot;"
				]
				Zorkda::GameOutput.add_lines(death_text)
				Zorkda::GameOutput.new_paragraph
			end
		end

	end
end