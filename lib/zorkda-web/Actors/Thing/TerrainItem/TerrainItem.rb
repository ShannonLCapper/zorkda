module Zorkda
	module Actors

		class TerrainItem < Thing
			attr_accessor :name, :description, :contents, :gen_plural, :gen_singular,
			:effective_items, :old_name, :parent_alias, :parent_singular, :parent_plural,
			:random_contents

			def initialize(name, description, distance)
				super()
				@name = name
				@description = description
				@distance = distance
				@original_distance = distance
				@visible = true
				@contents = nil	
				@gen_singular = "terrain item"
				@gen_plural = "terrain items"	
				@weight = 1
				@effective_items = []
				@respawn = false
				@can_pick_up = true
				@can_slide = false
				@can_roll_into = false
				@breakable = true
				@cuttable = false
				@flammable = false
				@hookshotable = false
				@old_name = nil
				@parent_alias = false
				@random_contents = false
			end

			def hit_with_bomb(game_status, damage)
				curr_room = game_status.curr_room
				player = game_status.player
				move_counter = game_status.move_counter
				item_removed = false
				if self.effective_items != nil && self.effective_items.include?("bomb") && !self.submerged
					if self.breakable
						self.break(curr_room, player)
						curr_room.inventory.delete(self)
						item_removed = true
					elsif self.is_a?(Zorkda::Actors::DiamondSwitch)
						self.activate(move_counter, nil)
					end
				end
				return item_removed
			end

			def break(curr_room, player)
				if self.contents != nil && self.contents.length > 0
					text_line = "The #{self.name} breaks, giving you the following: "
					(self.contents.length - 1).times do |i|
						separator = self.contents.length > 2 ? ", " : " "
						text_line += self.contents[i].name + separator
					end
					text_line += "and " if self.contents.length > 1
					text_line += "#{self.contents.last.name}"
					Zorkda::GameOutput.add_line(text_line)
					self.contents.each do |item|
						player.add_to_protagonist(item)
					end
				else
					Zorkda::GameOutput.add_line("The #{self.name} breaks, but nothing was in it.")
				end
				if self.respawn
					curr_room.respawn << self
				end
				curr_room.inventory.delete(self)
			end

			def pick_up(game_status)
				player = game_status.player
				curr_room = game_status.curr_room
				move_counter = game_status.move_counter
				self.description = nil
				if self.drop_name_if_picked_up == true
					self.old_name = self.name
					self.name = self.gen_singular
				end
				player.carrying = self
				if self.respawn_while_in_room
					curr_room.respawn_while_in_room << self
				end
				if self.is_a?(Zorkda::Actors::BombFlower)
					self.fuse_lit = true
					self.moves_when_activated = move_counter
					self.moves_when_removed = move_counter
				end
				curr_room.inventory.delete(self)
			end

			def cut(curr_room, player, move_counter)
				if self.contents != nil && self.contents.length > 0
					text_line = "You cut the #{self.name}, which gives you the following: "
					(self.contents.length - 1).times do |i|
						separator = self.contents.length > 2 ? ", " : " "
						text_line += self.contents[i].name + separator
					end
					text_line += "and " if self.contents.length > 1
					text_line += "#{self.contents.last.name}"
					Zorkda::GameOutput.add_line(text_line)
					self.contents.each do |item|
						player.add_to_protagonist(item)
					end
				else
					Zorkda::GameOutput.add_line("You cut the #{self.name}, but nothing was in it.")
				end
				if self.respawn_while_in_room
					curr_room.respawn_while_in_room << self
					self.moves_when_removed = move_counter
				elsif self.respawn
					curr_room.respawn << self
				end
				curr_room.inventory.delete(self)
			end
		end

	end
end