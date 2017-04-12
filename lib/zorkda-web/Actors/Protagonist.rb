module Zorkda
	module Actors

		#TODO: figure out what to do when player dies
		class Protagonist
			attr_accessor :name, :inventory, :equipment, :health_curr, :health_max, :heart_pieces, 
			:rupees_curr, :rupees_max, :strength, :carrying, :weight, :age, :on_fire, :diving_distance,
			:child_equipped_equipment, :adult_equipped_equipment, :heat_resistance, :underwater_breathing,
			:frozen, :moves_when_frozen, :paralyzed, :moves_when_paralyzed, :can_move, :breath_left, :deku_sticks,
			:has_bow, :has_bombs, :has_slingshot, :tokens, :stones, :medallions, :speed, :dead
			
			def initialize(name)
				@name = name
				#always have the deku stick holder be the 0th inventory item!!!! Needs to be that way for the dive and light commands
				@inventory = [Zorkda::Actors::DekuStickHolder.new, Zorkda::Actors::DekuNutHolder.new]
				@equipment = [Zorkda::Actors::KokiriTunic.new, Zorkda::Actors::KokiriBoots.new]
				@deku_sticks = @inventory[0]
				@health_curr = 3.0
				@health_max = 3.0
				@dead = false
				@heart_pieces = 0
				@rupees_curr = 0
				@rupees_max = 99
				@strength = 1
				@speed = 10
				@carrying = nil
				@weight = 1
				@age = "child"
				@child_equipped_equipment = @equipment
				@adult_equipped_equipment = @equipment
				@heat_resistance = 0
				@underwater_breathing = 0
				@diving_distance = 1
				@frozen = false
				@moves_when_frozen = nil
				@paralyzed = false
				@moves_when_paralyzed = nil
				@on_fire = false
				@can_move = true
				@breath_left = 4
				@has_bow = false
				@has_bombs = false
				@has_slingshot = false
				@tokens = 0
				@stones = []
				@medallions = []
			end

			def respawn
				self.carrying = nil
				self.health_curr = 3.0
				self.frozen = false
				self.moves_when_frozen = nil
				self.paralyzed = false
				self.moves_when_paralyzed = nil
				self.of_fire = false
				self.can_move = true
				self.breath_left = 4
				self.dead = false
			end

			def display_inventory
				Zorkda::GameOutput.add_line("This is what is in your inventory:")
				self.inventory.each do |item| 	
					if item.display_item == true
						Zorkda::GameOutput.add_line(item.name)
						if self.age == "child" && !item.available_as_child 
							Zorkda::GameOutput.append_text(" (only available as adult)")
						elsif self.age == "adult" && !item.available_as_adult
							Zorkda::GameOutput.append_text(" (only available as child)")
						elsif item.uses != 1.0 / 0.0
							Zorkda::GameOutput.append_text(": (#{item.uses.to_i} out of #{item.max_uses.to_i}")
							if item.ammo_type != nil
								Zorkda::GameOutput.append_text(" #{item.ammo_type})")
							else
								Zorkda::GameOutput.append_text(")")
							end
						end
					end
				end
			end

			def display_equipment
				Zorkda::GameOutput.add_line("This is what equipment you have:")
				self.equipment.each do |piece| 
					Zorkda::GameOutput.add_line(piece.name)
					if piece.equipped == true
						Zorkda::GameOutput.append_text(" (equipped)")
					end
					if self.age == "child" && !piece.available_as_child 
						Zorkda::GameOutput.append_text(" (only available as adult)")
					elsif self.age == "adult" && !piece.available_as_adult
						Zorkda::GameOutput.append_text(" (only available as child)")
					end
				end
			end

			def display_health
				if self.health_curr == self.health_curr.to_i.to_f
					Zorkda::GameOutput.add_line("#{self.health_curr.to_i} out of #{self.health_max.to_i} hearts")
				else
					Zorkda::GameOutput.add_line("#{self.health_curr} out of #{self.health_max.to_i} hearts")
				end
			end

			def display_heart_pieces
				Zorkda::GameOutput.add_line("#{self.heart_pieces.to_i} out of 4 heart pieces")
				Zorkda::GameOutput.add_line("(#{4 - self.heart_pieces.to_i} away from a new heart container)")
			end

			def display_wallet
				Zorkda::GameOutput.add_line("#{self.rupees_curr.to_i} out of #{self.rupees_max} rupees")
			end

			def display_tokens
				if self.tokens != 1
					Zorkda::GameOutput.add_line("You have #{self.tokens.to_i} gold skulltula tokens.")
				else
					Zorkda::GameOutput.add_line("You have 1 gold skulltula token.")
				end
			end

			def display_stones
				if self.stones.length == 0
					Zorkda::GameOutput.add_line("You don't have any spiritual stones.")
				else
					Zorkda::GameOutput.add_line("You have the following spiritual stones: ")
					stone_names = []
					self.stones.each {|stone| stone_names << stone.name }
					Zorkda::GameOutput.append_text(stone_names.join(", "))
				end
			end

			def display_medallions
				if self.medallions.length == 0
					Zorkda::GameOutput.add_line("You don't have any medallions.")
				else
					Zorkda::GameOutput.add_line("You have the following medallions: ")
					medallion_names = []
					self.medallions.each {|medallion| medallion_names << medallion.name }
					Zorkda::GameOutput.append_text(medallion_names.join(", "))
				end
			end

			def display_carrying
				if self.carrying == nil
					Zorkda::GameOutput.add_line("You aren't currently carrying anything in your arms.")
				else
					Zorkda::GameOutput.add_line("You are currently carrying the following item: #{self.carrying.name}")
				end
			end

			def add_to_protagonist(item)
				#if its a rupee, add to wallet
				if item.kind_of?(Rupee)
					self.get_rupees(item.value)
				#if its a heart, add to health
				elsif item.kind_of?(Heart)
					self.get_health(item.value)
				#if its a heart piece/container
				elsif item.kind_of?(HeartPiece)
					self.get_heart_piece(item.value)
				#if its an inventory ammo, add to weapon's uses
				elsif item.kind_of?(InventoryAmmo)
					item.add_to_weapon(self.inventory)
				#if its some other kind of inventory item, add to inventory
				elsif item.kind_of?(InventoryItem)
					Zorkda::GameOutput.add_line("The #{item.name} has been added to your inventory!")
					if item.replace_previous
						self.inventory.each do |thing|
							if thing.type.downcase == item.type.downcase
								self.inventory.delete(thing)
							end
						end
					end
					self.inventory << item
					if item.acquired_description != nil
						Zorkda::GameOutput.add_line(item.acquired_description)
					end
					if item.is_a?(Bow)
						self.has_bow = true
					elsif item.is_a?(BombBag)
						self.has_bombs = true
					elsif item.is_a?(Slingshot)
						self.has_slingshot = true
					end
				#if its a piece of equipment, add to equipment
				elsif item.kind_of?(Equipment)
					same_type_equipment = []
					self.equipment.each do |piece|
						if piece.type.downcase == item.type.downcase
							same_type_equipment << piece
						end
					end
					if same_type_equipment.length == 0 && (item.available_as_child && self.age == "child" || item.available_as_adult && self.age == "adult")
						if item.gen_singular == item.gen_plural
							Zorkda::GameOutput.add_line("The #{item.name} have been added to your equipment, and are now equipped!")
						else
							Zorkda::GameOutput.add_line("The #{item.name} has been added to your equipment, and is now equipped!")
						end
						equip_piece(item)
					elsif item.replace_previous
						if item.gen_singular == item.gen_plural
							Zorkda::GameOutput.add_line("The #{item.name} replace your #{same_type_equipment[0].name}, and are now equipped!")
						else
							Zorkda::GameOutput.add_line("The #{item.name} replaces your #{same_type_equipment[0].name}, and is now equipped!")
						end
						self.deequip_piece(same_type_equipment[0])
						self.equipment.delete(same_type_equipment[0])
						self.equip_piece(item)
					else
						if item.gen_singular == item.gen_plural
							Zorkda::GameOutput.add_line("The #{item.name} have been added to your equipment!")
						else
							Zorkda::GameOutput.add_line("The #{item.name} has been added to your equipment!")
						end
						Zorkda::GameOutput.add_line("You can equip this item by typing &quot;equip #{item.name}&qout;.")
					end
					self.equipment << item
					if item.acquired_description != nil
						Zorkda::GameOutput.add_line(item.acquired_description)
					end
				elsif item.kind_of?(GoldSkulltulaToken)
					Zorkda::GameOutput.add_line("This token is proof of the Gold Skulltula's destruction.")
					self.tokens += 1
				elsif item.kind_of?(SpiritualStone)
					self.stones << item
					Zorkda::GameOutput.new_paragraph
				elsif item.kind_of?(Medallion)
					self.medallions << item
				else
					Zorkda::GameOutput.add_line("I don't know how to add that equipment to you yet. Oops.")
				end
			end

			def get_health(health_val)
				if self.health_curr < self.health_max
					new_val = self.health_curr + health_val
					if new_val < self.health_max
						self.health_curr = new_val
					else
						Zorkda::GameOutput.add_line("Your health meter is now full.")
						self.health_curr = self.health_max
					end
				end
			end

			def receive_damage(game_status, damage)
				if self.health_curr <= damage
					Zorkda::GameOutput.add_line("You just died.")
					self.die(game_status)
				else
					self.health_curr -= damage
					if damage == 1
						Zorkda::GameOutput.add_line("You lose #{damage} heart.")
					else
						Zorkda::GameOutput.add_line("You lose #{damage} hearts.")
					end
				end
			end

			def get_heart_piece(value)
				self.heart_pieces += value
				self.health_curr = self.health_max
				if self.heart_pieces >= 4
					self.heart_pieces -= 4
					self.health_max += 1.0
					Zorkda::GameOutput.add_line("Your health meter has been extended by one heart!")
				else
					Zorkda::GameOutput.add_line("You are now only #{(4 - self.heart_pieces).to_i} heart pieces away from a new heart container!")
				end
			end

			def get_rupees(rupee_val)
				if self.rupees_curr < self.rupees_max
					new_val = self.rupees_curr + rupee_val
					if new_val < self.rupees_max
						self.rupees_curr = new_val
					else
						Zorkda::GameOutput.add_line("Your wallet is now full.")
						self.rupees_curr = self.rupees_max
					end
				end
			end

			def lose_rupees(rupee_val)
				if self.rupees_curr > 0
					new_val = self.rupees_curr - rupee_val
					if new_val > 0
						self.rupees_curr = new_val
					else
						Zorkda::GameOutput.add_line("Your wallet is now empty.")
						self.rupees_curr = 0
					end
				end
			end

			def update_player(game_status)
				move_counter = game_status.move_counter
				curr_room = game_status.curr_room
				self.check_if_too_hot(game_status)
				self.check_if_underwater(game_status)
				self.check_if_on_fire
				self.check_if_frozen(move_counter)
				self.check_if_paralyzed(move_counter)
				self.check_if_deku_stick_burned_out(move_counter)
				self.check_if_holding_exploding_bomb(game_status)
			end

			def check_if_holding_exploding_bomb(game_status)
				if self.carrying.is_a?(BombFlower) || self.carrying.is_a?(LitBomb)
					if move_counter > self.carrying.moves_when_activated + self.carrying.moves_to_explode
						Zorkda::GameOutput.add_line("The #{self.carrying.name} explodes in your hands.")
						self.carrying.fuse_lit = false
						self.carrying.moves_when_activated = nil
						self.receive_damage(game_status, self.carrying.damage_link)
						self.carrying = nil
					end
				end
			end

			def check_if_deku_stick_burned_out(move_counter)
				self.deku_sticks.update_lit_deku_stick(move_counter)
			end

			def die(game_status)

				Zorkda::GameOutput.add_line("Game over")
				3.times { Zorkda::GameOutput.new_paragraph }
				Zorkda::GameOutput.add_line("Type any command to continue.")
				#TODO: what should happen here?
				# puts "Would you like to continue from your last save point?"
				# response = get_valid_yes_or_no
				# if response == "yes"
				# 	load_game(game_status.file_name)
				# else
				# 	puts "Ok then. Hyrule needs you, so come back soon!"
				# 	exit(0)
				# end
			end

			def check_if_too_hot(game_status)
				if game_status.curr_room.hot && self.heat_resistance < 1
					Zorkda::GameOutput.add_line("It's too hot in here!")
					self.receive_damage(game_status, 0.5)
				end
			end

			def check_if_underwater(game_status)
				if game_status.curr_room.underwater && self.underwater_breathing < 1
					self.breath_left -= 1
					if self.breath_left == 0
						Zorkda::GameOutput.add_line("You just drowned.")
						self.die(game_status)
					else
						Zorkda::GameOutput.add_line("You're going to drown if you don't do something!")
					end
				else
					self.breath_left = 4
				end
			end

			def check_if_on_fire
				if self.on_fire
					self.equipment.each do |piece|
						if piece.equipped && piece.susceptible_to_fire
							Zorkda::GameOutput.add_line("Your #{piece.name} burns away!")
							self.equipment.delete(piece)
						end
					end
					self.on_fire = false
				end
			end

			def check_if_frozen(move_counter)
				if self.frozen && move_counter > self.moves_when_frozen + 2
					Zorkda::GameOutput.add_line("You thaw out and can now move.")
					self.frozen = false
					self.moves_when_frozen = nil
					self.can_move = true
				end
			end

			def check_if_paralyzed(move_counter)
				if self.paralyzed && move_counter > self.moves_when_paralyzed + 2
					Zorkda::GameOutput.add_line("You regain control of your muscles and can now move.")
					self.paralyzed = false
					self.moves_when_paralyzed = nil
					self.can_move = true
				end
			end

			def freeze(move_counter)
				Zorkda::GameOutput.add_line("You freeze into a block of ice and can't move an inch.")
				self.frozen = true
				self.moves_when_frozen = move_counter
				self.can_move = false
			end

			def paralyze(move_counter)
				Zorkda::GameOutput.add_line("You are suddenly paralyzed.")
				self.paralyzed = true
				self.moves_when_paralyzed = move_counter
				self.can_move = false
			end



			def equip_piece(piece)
				piece.equipped = true
				self.strength += piece.strength
				self.heat_resistance += piece.heat_resistance
				self.underwater_breathing += piece.underwater_breathing
				self.weight += piece.weight
				self.diving_distance += piece.diving_distance
			end

			def deequip_piece(piece)
				piece.equipped = false
				self.strength -= piece.strength
				self.heat_resistance -= piece.heat_resistance
				self.underwater_breathing -= piece.underwater_breathing
				self.weight -= piece.weight
				self.diving_distance -= piece.diving_distance
			end

			# def change_age
			# 	if self.age == "child"
			# 		self.age = "adult"
			# 		self.strength += 1
			# 		self.child_equipped_equipment = []
			# 		self.equipment.each do |piece|
			# 			if piece.equipped
			# 				self.child_equipped_equipment << piece
			# 				if !piece.available_as_adult
			# 					deequip_piece(piece)
			# 				end

		end

	end
end