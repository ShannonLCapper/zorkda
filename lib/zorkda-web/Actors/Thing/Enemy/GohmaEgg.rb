module Zorkda
	module Actors

		#DONE
		class GohmaEgg < Enemy

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
				curr_room.enemies.insert(enemy_index, Zorkda::Actors::GohmaLarva.new(nil, nil, self.distance))
				Zorkda::GameOutput.add_line("#{self.name} hatched into a Gohma larva.")
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

	end
end