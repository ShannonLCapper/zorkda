class Terrain_item < Thing
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
			elsif self.is_a?(Diamond_switch)
				self.activate(move_counter, nil)
			end
		end
		return item_removed
	end

	def break(curr_room, player)
		if self.contents != nil && self.contents.length > 0
			print "The #{self.name} breaks, giving you the following: "
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
			puts "The #{self.name} breaks, but nothing was in it."
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
		if self.is_a?(Bomb_flower)
			self.fuse_lit = true
			self.moves_when_activated = move_counter
			self.moves_when_removed = move_counter
		end
		curr_room.inventory.delete(self)
	end

	def cut(curr_room, player, move_counter)
		if self.contents != nil && self.contents.length > 0
			print "You cut the #{self.name}, which gives you the following: "
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
			puts "You cut the #{self.name}, but nothing was in it."
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

class Pot < Terrain_item

	attr_accessor :break_when_thrown

	def initialize(name, description, distance, contents)
		super(name, description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@contents = contents
		@break_when_thrown = true
		@gen_singular = "pot"
		@gen_plural = "pots"
		@effective_items = ["sword", "slingshot", "boomerang", 
			"bow", "bomb", "hookshot", "stick", "hammer"]
		@respawn = true
		@can_roll_into = true
		@drop_name_if_picked_up = true
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Grass < Terrain_item


	def initialize(name, description, distance, contents)
		super(name, description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@can_pick_up = false
		@cuttable = true
		@breakable = false
		@gen_singular = "grass"
		@gen_plural = "grass"
		@effective_items = ["sword"]
		@respawn = true
		if @name == nil
			@name = @gen_singular
		end
	end

	def cut(game_status)
		curr_room = game_status.curr_room
		player = game_status.player
		if self.cuttable
			if self.contents != nil && self.contents.length > 0
				print "You cut the #{self.name}, giving you the following: "
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
				puts "You cut the #{self.name}, but nothing was in it."
			end
			if self.respawn
				curr_room.respawn << self
			end
			curr_room.inventory.delete(self)
		end
	end
end


class Weed < Terrain_item

	attr_accessor :moves_when_removed
	
	def initialize(name, description, distance, contents)
		super(name, description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@can_pick_up = false
		@cuttable = true
		@breakable = false
		@gen_singular = "weed"
		@gen_plural = "weeds"
		@effective_items = ["sword"]
		@respawn_while_in_room = true
		@respawn_time = 4
		@moves_when_removed = nil
		if @name == nil
			@name = @gen_singular
		end
	end

	def cut(game_status)
		curr_room = game_status.curr_room
		player = game_status.player
		if self.contents != nil && self.contents.length > 0
			print "You cut the #{self.name}, giving you the following: "
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
			puts "You cut the #{self.name}, but nothing was in it."
		end
		self.moves_when_removed = game_status.move_counter
		curr_room.respawn_while_in_room << self
		curr_room.inventory.delete(self)
	end
end

class Box < Terrain_item

	attr_accessor :break_when_thrown
	
	def initialize(name, description, distance, contents)
		super(name, description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@break_when_thrown = true
		@gen_singular = "box"
		@gen_plural = "boxes"
		@effective_items = ["bomb", "hammer"]
		@respawn = true
		@can_roll_into = true
		@drop_name_if_picked_up = true
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Rock < Terrain_item
	
	attr_accessor :break_when_thrown
	
	def initialize(name, description, distance, contents)
		super(name, description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@weight = 0
		@break_when_thrown = true
		@breakable = true
		@gen_singular = "rock"
		@gen_plural = "rocks"
		@respawn = true
		@drop_name_if_picked_up = true
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Breakable_wall < Terrain_item

	def initialize(direction, distance)
		super(direction + " wall", nil, distance)
		@gen_singular = "wall"
		@gen_plural = "walls"
		@parent_alias = true
		@parent_singular = "fragile wall"
		@parent_plural = "fragile walls"
		@can_pick_up = false
		@breakable = true
		@display = false
		@effective_items = ["bomb"]
	end

	def break(curr_room, player)
		puts "The #{self.name} breaks away, revealing an opening behind it."
		curr_room.inventory.delete(self)
	end
end

class Tree < Terrain_item

	def initialize(name, description, distance, contents)
		super(name, description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@can_pick_up = false
		@breakable = false
		@hookshotable = true
		@can_roll_into = true
		@gen_singular = "tree"
		@gen_plural = "trees"
		if name == nil
			@name = @gen_singular
		end
	end
end

class Bomb_flower < Terrain_item
	attr_accessor :fuse_lit, :moves_when_activated, :moves_to_explode, :damage_link, :damage_enemy, :moves_when_removed

	def initialize(name, description, distance)
		super(name, description, distance)
		@fuse_lit = false
		@moves_to_explode = 3
		@respawn_time = 4
		@drop_name_if_picked_up = true
		@weight = 2
		@breakable = false
		@moves_when_activated = nil
		@moves_when_removed = nil
		@respawn_while_in_room = true
		@damage_link = 0.5
		@damage_enemy = 2
		@gen_singular = "bomb flower"
		@gen_plural = "bomb flowers"
		if @name == nil
			@hame = @gen_singular
		end
	end

end

class Lit_bomb < Terrain_item
	attr_accessor :fuse_lit, :moves_when_activated, :moves_to_explode, :damage_link, :damage_enemy

	def initialize(moves_when_activated)
		super("lit bomb", nil, 0)
		@fuse_lit = true
		@moves_to_explode = 2
		@weight = 2
		@breakable = false
		@moves_when_activated = moves_when_activated
		@damage_link = 0.5
		@damage_enemy = 2
		@gen_singular = "lit bomb"
		@gen_plural = "lit bombs"
	end
end


class Torch < Terrain_item

	attr_accessor :moves_when_activated, :moves_to_reset
	
	def initialize(name, description, distance, on_fire)
		super(name, description, distance)
		@on_fire = on_fire
		@moves_when_activated = nil
		@moves_to_reset = 1.0/0.0
		@flammable = true
		@can_pick_up = false
		@breakable = false
		@hookshotable = true
		@gen_singular = "torch"
		@gen_plural = "torches"
		@has_parenthetical_name = true
		if on_fire
			@parenthetical_name = "lit"
		else
			@parenthetical_name = "unlit"
		end
		if @name == nil
			@name = @gen_singular
		end
	end

	def light(game_status)
		if self.on_fire
			puts "The #{self.name} is already lit."
		else
			puts "The #{self.name} is now lit."
			self.on_fire = true
			self.moves_when_activated = game_status.move_counter
			self.parenthetical_name = "lit"
		end
	end
end

class Temporary_torch < Torch

	def initialize(name, description, distance, moves_to_reset)
		super(name, description, distance, false)
		@moves_to_reset = moves_to_reset
	end

	def update_if_should_go_out(move_counter)
		if self.on_fire && move_counter > self.moves_when_activated + self.moves_to_reset
			puts "The #{self.name} went out."
			self.on_fire = false
			self.moves_when_activated = nil
			self.parenthetical_name = "unlit"
		end
	end
end

class Boulder < Terrain_item
	
	@@weights = {"brown" => 3, "silver" => 4, "bronze" => 5}
	@@breakables = {"brown" => true, "silver" => false, "bronze" => false}
	@@poss_effective_items = {"brown" => ["bomb", "hammer"], "silver" => nil, "bronze" => nil}

	attr_accessor :drop_name_if_picked_up
	
	def initialize(color, description, distance, contents, respawn)
		super("#{color} boulder", description, distance)
		if contents.is_a?(String) && contents.upcase == "RNG"
			@random_contents = true
			@contents = nil
		else
			@contents = contents
		end
		@weight = @@weights[color]
		@breakable = @@breakables[color]
		@gen_singular = "boulder"
		@gen_plural = "boulders"
		@effective_items = @@poss_effective_items[color]
		@respawn = respawn
		@drop_name_if_picked_up = true
	end
end

class Chest < Terrain_item
	
	attr_accessor :is_open, :boss_key_needed
	
	def initialize(name, description, distance, contents)
		super(name, description, distance)
		@contents = contents
		@hookshotable = true
		@can_pick_up = false
		@breakable = false
		@openable = true
		@gen_singular = "chest"
		@gen_plural = "chests"
		@parent_alias = false
		@parent_singular = nil
		@parent_plural = nil
		@is_open = false
		@boss_key_needed = false
		if @name == nil
			@name = @gen_singular
		end
	end

	def open(player)
		if self.contents.is_a?(Array)
			self.contents = self.contents[0]
		end
		print "You push back the lid to find "
		if self.contents.is_a?(Equipment) || (self.contents.is_a?(Inventory_item) && !self.contents.is_a?(Inventory_ammo) && !self.contents.is_a?(Bottle))
			puts "the #{self.contents.name}!"
		elsif self.contents.gen_singular == self.contents.gen_plural
			puts "some #{self.contents.name}!"
		else
			puts "a #{self.contents.name}!"
		end
		player.add_to_protagonist(self.contents)
		self.parent_alias = true
		self.parent_singular = name
		self.parent_plural = name
		self.name = "open " + self.name
		self.is_open = true
		self.description = nil
	end
end

class Block < Terrain_item
	
	attr_accessor :slid, :unslid_desc, :slid_desc, :when_moved, :can_slide_back, :path_clear
	
	def initialize(name, unslid_desc, slid_desc, distance, can_slide_back, path_clear)
		@unslid_desc = unslid_desc
		@slid_desc = slid_desc
		super(name, unslid_desc, distance)
		@slid = false
		@path_clear = path_clear
		@can_slide = true
		@can_slide_back = can_slide_back
		@can_pick_up = false
		@breakable = false
		@gen_plural = "blocks"
		@gen_singular = "block"
		@when_moved = nil
		if @name == nil
			@name = @gen_singular
		end
	end

	def slide(move_counter)
		self.slid = true
		self.description = self.slid_desc
		self.when_moved = move_counter
		
	end

	def unslide(move_counter)
		self.slid = false
		self.description = self.unslid_desc
		self.when_moved = move_counter
	end
end

class Spiderweb < Terrain_item
	
	def initialize(name, description, distance)
		super(name, description, distance)
		@flammable = true
		@can_pick_up = false
		@breakable = false
		@gen_singular = "spiderweb"
		@gen_plural = "spiderwebs"
		if @name == nil
			@name = @gen_singular
		end
	end

	def light(game_status)
		puts "The #{self.name} burns away."
		game_status.curr_room.inventory.delete(self)
	end
end

class Switch < Terrain_item
	
	attr_accessor :activated, :moves_to_reset, :moves_when_activated,
	:parent_singular, :parent_plural, :parent_alias, :moves_when_deactivated
	
	def initialize(name, description, distance)
		super(name, description, distance)
		@activated = false
		@moves_to_reset = 0
		@moves_when_activated = 0
		@moves_when_deactivated = 1.0/0.0
		@can_pick_up = false
		@breakable = false
		@parent_alias = true
		@parent_singular = "switch"
		@parent_plural = "switches"
		@gen_plural = "switches"
		@gen_singular = "switch"
	end

	def hit(game_status)
		self.activate(game_status.move_counter)
	end

	def check_deactivation(move_counter)
	end

end

class Floor_switch < Switch
	
	attr_accessor :pressure, :held_down_by
	
	def initialize(name, description, distance, pressure)
		super(name, description, distance)
		@pressure = pressure
		@gen_singular = "floor switch"
		@gen_plural = "floor switches"
		@held_down_by = nil
		@can_step_on = true
		if @name == nil
			@name = @gen_singular
		end
	end

	def activate(move_counter)
		self.activated = true
		puts "The #{self.name} has been pressed down."
		self.moves_when_activated = move_counter
	end

	def deactivate(move_counter)
		self.moves_when_deactivated = move_counter
		self.activated = false
		puts "The #{self.name} returns to its unpressed state."
	end

	def update_held_down(room_inventory, move_counter)
		if self.held_down_by != nil && !room_inventory.include?(self.held_down_by)
			puts "The #{self.name} is no longer being held down."
			self.held_down_by = nil
			#for some reason, this method holds the switch down for 1 move longer than it should, so the -1 is to correct for that
			self.moves_when_activated = move_counter - 1
		end
	end

	def check_deactivation(move_counter)
		if self.activated == true && self.held_down_by == nil
			deactivate(move_counter)
		end
	end

end

class Floor_switch_sticky < Floor_switch

	def initialize(name, description, distance, pressure, moves_to_reset)
		super(name, description, distance, pressure)
		@moves_to_reset = moves_to_reset
	end

	def check_deactivation(move_counter)
		if self.activated == true && self.held_down_by == nil && 
		move_counter > self.moves_when_activated + self.moves_to_reset
			deactivate(move_counter)
		end
	end
end


class Diamond_switch < Switch
	
	def initialize(name, description, distance, moves_to_reset)
		super(name, description, distance)
		@moves_to_reset = moves_to_reset
		@gen_singular = "diamond switch"
		@gen_plural = "diamond switches"
		@hittable = true
		@effective_items = ["sword", "slingshot", "boomerang", 
			"bow", "bomb", "hookshot", "longshot", "stick", "hammer"]
		if @name == nil
			@name = @gen_singular
		end
	end

	def activate(move_counter)
		self.activated = true
		puts "The #{self.name} glows yellow."
		self.moves_when_activated = move_counter
	end

	def deactivate(move_counter)
		self.moves_when_deactivated = move_counter
		self.activated = false
		puts "The #{self.name} returns to its inactive state."
	end

	def check_deactivation(move_counter)
		if self.activated == true && move_counter > self.moves_when_activated + self.moves_to_reset
			deactivate(move_counter)
		end
	end
end

class Eye_switch < Switch
	
	def initialize(name, description, distance, moves_to_reset)
		super(name, description, distance)
		@moves_to_reset = moves_to_reset
		@gen_singular = "eye switch"
		@gen_plural = "eye switches"
		@hittable = true
		@effective_items = ["bow", "slingshot"]
		if @name == nil
			@name = @gen_singular
		end
	end

	def activate(move_counter)
		self.activated = true
		puts "The eye of the #{self.name} closes."
		self.moves_when_activated = move_counter
	end

	def deactivate(move_counter)
		self.moves_when_deactivated = move_counter
		self.activated = false
		puts "The eye of the #{self.name} returns to its open state."
	end

	def check_deactivation(move_counter)
		if self.activated == true && move_counter > self.moves_when_activated + self.moves_to_reset
			deactivate(move_counter)
		end
	end

end

class Ladder_switch < Switch

	def initialize
		super("ladder", "there is a ladder suspended in cobwebs above the east door", 5)
		@moves_to_reset = 1.0/0.0
		@hittable = true
		@effective_items = ["slingshot"]
		@gen_singular = "ladder"
		@gen_plural = "ladders"
		@parent_alias = false
	end

	def activate(move_counter)
		self.activated = true
		puts "The ladder falls from the cobwebs, landing propped against the east wall."
		self.description = "there is a ladder resting against the east wall"
		self.moves_when_activated = move_counter
		self.distance = 0
		self.effective_items = []
	end

end