module Zorkda
	module Rooms

		#DONE
		class Room

			attr_accessor :name, :description, :location, :nside, :sside, :eside, :wside, 
			:uside, :dside, :inventory, :characters, :enemies, :respawn, :respawn_while_in_room, 
			:visited_before, :hot, :underwater, :contains_portal, :portal_goes_to, 
			:has_entry_cutscene, :checkpoint_cutscene_list, :floor, :navi_hint, :respawn_point

			def initialize
				@name = "Room"
				@description = nil
				@location = nil
				@floor = nil
				@nside = Barrier.new("north", :stone_wall)
				@sside = Barrier.new("south", :stone_wall)
				@eside = Barrier.new("east", :stone_wall)
				@wside = Barrier.new("west", :stone_wall)
				@uside = Barrier.new("up", :sky)
				@dside = Barrier.new("down", :floor)
				@inventory = []
				@characters = []
				@enemies = []
				@respawn = []
				@respawn_while_in_room = []
				@visited_before = false
				@hot = false
				@underwater = false
				@contains_portal = false
				@portal_goes_to = nil
				@has_entry_cutscene = false
				@checkpoint_cutscene_list = []
				@navi_hint = nil
				@respawn_point = nil
			end

			def update_room_conditions(game_status)
				player = game_status.player
				move_counter = game_status.move_counter
				self.update_bombs(game_status)
				self.update_switches(self.inventory, move_counter)
				self.update_temp_torches(self.inventory, move_counter)
				self.update_locks(game_status)
				self.update_distances(game_status)
				self.check_respawn_while_in_room(player, move_counter)
				self.update_names
				self.update_navi_hint(game_status)
				
			end


			def update_temp_torches(inventory, move_counter)
				inventory.each do |item|
					if item.is_a?(Zorkda::Actors::TemporaryTorch)
						item.update_if_should_go_out(move_counter)
					end
				end
			end

			def update_bombs(game_status)
				player = game_status.player
				move_counter = game_status.move_counter
				bombs_to_delete = []
				self.inventory.each do |item|
					if (item.is_a?(Zorkda::Actors::BombFlower) || item.is_a?(Zorkda::Actors::LitBomb)) && item.fuse_lit 
						if move_counter > item.moves_when_activated + item.moves_to_explode
							Zorkda::GameOutput.add_line("The #{item.name} explodes.")
							item.fuse_lit = false
							item.moves_when_activated = nil
							i = 0
							self.enemies.length.times do
								if self.enemies[i].distance == 0
									enemy_removed = self.enemies[i].hit_with_bomb(game_status, item.damage_enemy)
									if !enemy_removed
										i += 1
									end
								end
							end
							i = 0
							self.inventory.length.times do
								if self.inventory[i].distance == 0 && self.inventory[i] != item
									thing_removed = self.inventory[i].hit_with_bomb(game_status, item.damage_enemy)
									if !thing_removed
										i += 1
									end
								end
							end
							bombs_to_delete << item
						end
					end
				end
				bombs_to_delete.each do |bomb|
					self.inventory.delete(bomb)
				end
			end

			def check_respawn_while_in_room(player, move_counter)
				things_to_respawn = []
				self.respawn_while_in_room.each do |thing|
					if move_counter > thing.respawn_time + thing.moves_when_removed
						things_to_respawn << thing
					end
				end
				things_to_respawn.each do |thing|
					thing.moves_when_removed = nil
					Zorkda::GameOutput.add_line("The #{thing.name} reappeared.")
					if thing.random_contents
						thing.contents = Zorkda::Engine.rng_contents(player)
					end
					if thing.is_a?(Zorkda::Actors::Enemy)
						self.enemies << thing
					elsif thing.is_a?(Zorkda::Actors::Character)
						self.characters << thing
					else
						self.inventory << thing
					end
					self.respawn_while_in_room.delete(thing)
				end
			end

			def update_names
				number_generic_names_when_others_present(self.inventory)
				number_generic_names_when_others_present(self.enemies)
				number_generic_names_when_others_present(self.characters)
			end

			def number_generic_names_when_others_present(array)
				generic_singulars = []
				names = []
				array.each do |item|
					generic_singulars << item.gen_singular
					names << item.name
				end
				array.length.times do |i|
					if array[i].name == array[i].gen_singular && generic_singulars[0...i].concat(generic_singulars[(i + 1..-1)]).include?(array[i].gen_singular)
						num = 1
						while true
							if names[0...i].concat(names[(i + 1)..-1]).include?(array[i].name + " " + num.to_s)
								num += 1
							else
								array[i].name = array[i].name + " " + num.to_s
								names[i] = array[i].name
								break
							end
						end
					end
				end
			end

			def update_switches(inventory, move_counter)
				inventory.each do |item|
					if item.is_a?(Zorkda::Actors::Switch)
						if item.is_a?(Zorkda::Actors::FloorSwitch)
							item.update_held_down(inventory, move_counter)
						end
						item.check_deactivation(move_counter)
					end
				end
			end

			def update_locks(game_status)
			end

			def update_distances(game_status)
			end

			def update_navi_hint(game_status)
			end

			def block_distances_check(block, move_counter)
				if block.slid && block.when_moved == (move_counter - 1)
					move_all_closer
				elsif !block.slid && block.when_moved != nil && block.when_moved == move_counter - 1
					move_all_farther_if_needed
				end
			end
			
			def move_all_closer
				things_now_in_range = []
				sides_now_in_range = []
				objects_that_could_move = self.inventory + self.characters + self.enemies
				objects_that_could_move.each do |thing|
					if thing.distance > 0
						thing.distance -= 1
						if thing.distance == 0
							things_now_in_range << thing.name
						end
					end	
				end
				sides = [self.nside, self.sside, self.eside, self.wside, self.uside, self.dside]
				sides.each do |side|
					if side.distance > 0
						side.distance -= 1
						if side.distance == 0
							sides_now_in_range << side.direction
						end
					end
				end
				if things_now_in_range.length > 0
					self.print_array(things_now_in_range, "The following are now within reach:")
				end
				if sides_now_in_range.length > 0
					self.print_array(sides_now_in_range, "You can now reach the following directions:")
				end
			end

			def move_all_farther_if_needed
				things_no_longer_in_range = []
				sides_no_longer_in_range = []
				objects_that_could_move = self.inventory + self.characters + self.enemies
				objects_that_could_move.each.each do |thing|
					if thing.distance != thing.original_distance && thing.original_distance != nil
						thing.distance += 1
						things_no_longer_in_range << thing.name
					end
				end
				sides = [self.nside, self.sside, self.eside, self.wside, self.uside, self.dside]
				sides.each do |side|
					if side.distance != side.original_distance
						side.distance += 1
						sides_no_longer_in_range << side.direction
					end
				end
				if things_no_longer_in_range.length > 0
					self.print_array(things_no_longer_in_range, "These are now out of reach:")
				end
				if sides_no_longer_in_range.length > 0
					self.print_array(sides_no_longer_in_range, "You can no longer go")
					Zorkda::GameOutput.append_text(".")
				end
			end

			def move_all_farther_if_needed_silent
				objects_that_could_move = self.inventory + self.characters + self.enemies
				objects_that_could_move.each.each do |thing|
					if thing.distance != thing.original_distance && thing.original_distance != nil
						thing.distance += 1
					end
				end
				sides = [self.nside, self.sside, self.eside, self.wside, self.uside, self.dside]
				sides.each do |side|
					if side.distance != side.original_distance
						side.distance += 1
					end
				end
			end

			def print_array(array, message)
				if array.length > 1
					text_line = "#{message} "
					(array.length - 1).times do |i|
						text_line += array[i]
						text_line += array.length > 2 ? ", " : " "
					end
					text_line += "and #{array.last}"
				elsif array.length == 1
					text_line = "#{message} #{array.first}"
				end
				Zorkda::GameOutput.add_line(text_line)
			end

		end

	end
end