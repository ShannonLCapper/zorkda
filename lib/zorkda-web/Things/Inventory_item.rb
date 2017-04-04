class Inventory_item < Thing

	attr_accessor :uses, :max_uses, :damage_enemy, :range, :stun_enemy, :gen_singular, :gen_plural,
	:acquired_description, :type, :available_as_child, :available_as_adult, 
	:flammable, :can_throw, :can_shoot, :can_drop, :replace_previous, :quantity_allowed, :display_item,
	:quantity, :parent_alias, :parent_singular, :parent_plural, :can_hit_things

	def initialize(name, gen_singular, gen_plural)
		super()
		@name = name
		@gen_singular = gen_singular
		@gen_plural = gen_plural
		@can_pick_up = true
		@hittable = false
		@damage_enemy = 0
		@range = 0
		@display_item = true
		@acquired_description = nil
		@uses = 1.0/0.0
		@max_uses = 1.0/0.0
		@flammable = false
		@can_drop = false
		@can_throw = false
		@replace_previous = false
		@quantity_allowed = 1
		@quantity = 1
		@parent_alias = false
		@parent_singular = nil
		@parent_plural = nil
		@available_as_adult = true
		@available_as_child = true
		@can_hit_things = false
	end

	def use(game_status, target)
		player = game_status.player

		if player.carrying != nil
			puts "Your hands are full with something else. Drop that before using any inventory items."
		elsif self.uses <= 0
			puts "You are out of #{self.gen_plural}."
		else
			self.use_item(game_status, target)
		end
	end

	def use_item(game_status, target)
		puts "The code to use that item has not been written yet."
	end

	def pick_up(game_status)
		game_status.player.add_to_protagonist(self)
		if self.respawn
			game_status.curr_room.respawn << self
		end
		game_status.curr_room.inventory.delete(self)
	end

end

class Inventory_weapon < Inventory_item

	attr_accessor :ammo_type

	def initialize(name, gen_singular, gen_plural, damage_enemy, range)
		super(name, gen_singular, gen_plural)
		@damage_enemy = damage_enemy
		@range = range
		@ammo_type = nil
		@can_hit_things = true
	end

	def reduce_uses_left
		self.uses -= 1
		if self.uses == 0
			puts "You are now out of #{self.ammo_type}."
		end
	end
end

class Deku_stick_holder < Inventory_weapon

	attr_accessor :moves_when_lit, :moves_to_burn_out

	def initialize
		super("Deku Sticks", "Deku stick", "Deku sticks", 2, 0)
		@acquired_description = "Deku sticks can be used with the commands \"hit\", \"break\", and \"light\".
If your deku stick is on fire, you can put it out with \"extinguish stick\"."
		@type = "stick"
		@ammo_type = "sticks"
		@parent_alias = true
		@parent_singular = "stick"
		@parent_plural = "sticks"
		@uses = 0
		@max_uses = 10
		@available_as_adult = false
		@flammable = true
		@on_fire = false
		@moves_when_lit = nil
		@moves_to_burn_out = 3
		@display_item = false
	end	

	def use_item(game_status, target)
		player = game_status.player
		curr_room = game_status.curr_room
		stick_used = false
		if target.distance > self.range
			puts "That target is too far away to hit with a Deku stick."
		elsif curr_room.underwater || target.submerged
			puts "You can't use Deku sticks underwater."
		elsif target.is_a?(Character)
			puts "You don't have a lot of friends, do you?"
		elsif target.effective_items == nil || (!target.effective_items.include?(self.type) && !target.stunned_by.include?(self.type))
			if target.is_a?(Enemy)
				puts "You break your stick in your attack, but the enemy is unaffected."
			else
				puts "You break your stick in your wild swinging, but nothing else happens."
			end
			stick_used = true
		else
			if target.is_a?(Enemy)
				target.get_hit(game_status, self.type, self.damage_enemy, "You successfully injure the enemy, breaking your stick in the process.")
			elsif target.breakable
				target.break(curr_room, player)
				puts "But your stick broke too."
			end
			stick_used = true
		end
		if stick_used
			self.reduce_uses_left
			if self.on_fire
				self.on_fire = false
			end
		end
	end

	def light(move_counter)
		if self.uses <= 0
			puts "You don't have any Deku sticks left to light."
		else
			puts "You light a Deku stick on fire."
			self.on_fire = true
			self.moves_when_lit = move_counter
		end
	end

	def extinguish
		if !self.on_fire
			puts "You don't have any lit Deku sticks to extinguish."
		else
			puts "You extinguish your lit Deku stick."
			self.on_fire = false
		end
	end

	def update_lit_deku_stick(move_counter)
		if self.uses > 0 && self.on_fire && 
		move_counter > self.moves_when_lit + self.moves_to_burn_out
			puts "Your Deku stick burned away."
			self.reduce_uses_left
			self.on_fire = false
		end
	end

end

class Deku_nut_holder < Inventory_weapon

	def initialize
		super("Deku Nuts", "Deku nut", "Deku nuts", 0, 0)
		@acquired_description = "Deku nuts can be used to stun enemies. Use them with the commands \"hit\" and \"throw\"."
		@type = "nut"
		@ammo_type = "nuts"
		@parent_alias = true
		@parent_singular = "nut"
		@parent_plural = "nuts"
		@uses = 0
		@max_uses = 20
		@can_throw = true
		@display_item = false
	end

	def use_item(game_status, target)
		move_counter = game_status.move_counter
		curr_room = game_status.curr_room
		nut_used = false
		#no single target
		if target == nil
			if curr_room.underwater
				puts "You can't use Deku nuts underwater."
				return
			end
			nut_used = true
			if curr_room.enemies.length == 0
				puts "You throw a Deku nut with a flash, but there is no effect."
			else 
				enemies_in_range = []
				enemy_in_range = false
				curr_room.enemies.each do |enemy|
					if enemy.distance <= self.range && !enemy.submerged
						enemies_in_range << enemy
						enemy_in_range = true
					end
				end
				if enemies_in_range.length == 0
					puts "You throw a Deku nut, but no enemies are in range."
				else
					enemy_hit = false
					enemies_in_range.each do |enemy|
						if enemy.distance <= self.range && enemy.stunned_by.include?(self.type)
							enemy.stun(move_counter)
							enemy_hit = true
						end
					end
					if enemy_hit == false
						puts "You throw a Deku nut, but no enemies were affected."
					end
				end
			end
		#throw at single target
		else
			if target.distance > self.range
				puts "That target is too far away to hit with a Deku nut."
			elsif target.submerged
				puts "You can't hit something underwater with a Deku nut."
			elsif target.is_a?(Character)
				puts "Why don't you use your roguish good looks to stun people instead?"
			elsif target.is_a?(Enemy) && target.stunned_by.include?(self.type)
				target.stun(move_counter)
				nut_used = true
			else
				puts "You throw a Deku nut with a flash, but nothing happens."
				nut_used = true
			end
		end
		if nut_used
			self.reduce_uses_left
		end
	end

end

class Slingshot < Inventory_weapon

	def initialize
		super("Fairy Slingshot", "Deku seed", "Deku seeds", 1, 5)
		@acquired_description = "With this weapon, you can shoot deku seeds at distant things using the commands \"hit\", \"break\", and \"shoot\".
It came with a seed bag holding 30 deku seeds."
		@type = "slingshot"
		@uses = 30
		@max_uses = 30
		@parent_alias = true
		@ammo_type = "deku seeds"
		@parent_singular = "slingshot"
		@parent_plural = "slingshots"
		@can_shoot = true
		@available_as_adult = false
	end

	def use_item(game_status, target)
		curr_room = game_status.curr_room
		if curr_room.underwater
			puts "You can't use your slingshot underwater."
			return
		end
		seed_used = false
		if target.distance > self.range
			puts "That target is too far away to hit with your slingshot."
		elsif target.submerged
			puts "You can't hit something underwater with your slingshot."
		elsif target.is_a?(Character)
			puts "Isn't there something more productive you could be doing?"
		elsif target.effective_items == nil || (!target.effective_items.include?(self.type) && !target.stunned_by.include?(self.type))
			if target.is_a?(Enemy)
				puts "You fire your slingshot at the enemy, but it doesn't seem to care."
			else
				puts "You shoot a Deku seed at the #{target.name}, but nothing happens."
			end
			seed_used = true
		else
			if target.is_a?(Enemy)
				target.get_hit(game_status, self.type, self.damage_enemy, "You injure the enemy with your Deku seed projectile.")
			elsif target.breakable
				target.break(curr_room, game_status.player)
			elsif target.hittable
				target.hit(game_status)
			else
				puts "You shoot a Deku seed at the #{target.name}, but nothing happens."
			end
			seed_used = true
		end
		if seed_used
			self.reduce_uses_left
		end
	end
	
end

class Bomb_bag < Inventory_weapon

	def initialize
		super("Bombs", "bomb", "bombs", 2, 0)
		@type = "bomb"
		@ammo_type = "bombs"
		@acquired_description = "This bomb-holding bag is made from a Dodongo's stomach. 20 bombs are inside.
Use bombs with \"hit\" and \"throw\". 
If not directed at something in particular, bombs explode after 2 moves."
		@uses = 20
		@max_uses = 20
		@can_throw = true
		@can_drop = true
	end

	def use_item(game_status, target)
		move_counter = game_status.move_counter
		player = game_status.player
		curr_room = game_status.curr_room
		if curr_room.underwater
			puts "You can't use bombs underwater."
		elsif target == nil
			puts "You light the fuse on a bomb and throw it."
			curr_room.inventory << Lit_bomb.new(move_counter)
			self.reduce_uses_left
		elsif target.distance > self.range
			puts "Your intended target is too far away."
		elsif target.submerged
			puts "You can't hit something underwater with a bomb."
		elsif !target.effective_items.include?("bomb")
			puts "Your bomb hits the intended target and explodes, but nothing happens."
			self.reduce_uses_left
		else
			puts "Your bomb hits the intended target and explodes."
			target.hit_with_bomb(game_status, self.damage_enemy)
			self.reduce_uses_left
		end
	end
end

class Boomerang < Inventory_weapon

	def initialize
		super("Boomerang", "Boomerang", "Boomerangs", 1, 5)
		@type = "boomerang"
		@acquired_description = "With this weapon, you can hit distant enemies using the commands \"hit\", \"break\", and \"throw\"."
		@can_throw = true
		@available_as_adult = false
	end

	def use_item(game_status, target)
		curr_room = game_status.curr_room
		player = game_status.player
		move_counter = game_status.move_counter
		if curr_room.underwater
			puts "You can't use the boomerang underwater."
		elsif target == nil
			puts "You need to throw the boomerang at something."
		else
			puts "I don't have the code to do that yet."
		end
	end
end

class Hookshot < Inventory_weapon

	def initialize
		super("Hookshot", "Hookshot", "Hookshots", 2, 5)
		@type = "hookshot"
		@acquired_description = "This is a spring-loaded chain that you can cast out to hook things.
You can use it to drag distant items toward you, or you can use it to pull yourself toward something.
Use it with the commands \"hit\", \"break\", and \"shoot\"."
		@parent_alias = true
		@parent_singular = "hookshot"
		@parent_plural = "hookshots"
		@can_shoot = true
		@available_as_child = false
	end
end

class Bow < Inventory_weapon
		
	def initialize
		super("Fairy Bow", "arrow", "arrows", 2, 10)
		@type = "bow"
		@acquired_description = "With this weapon, you can shoot arrows at distant things using the commands \"hit\", \"break\", and \"shoot\".
It came with a quiver holding 30 arrows."
		@ammo_type = "arrows"
		@uses = 30
		@max_uses = 30 
		@parent_alias = true
		@parent_singular = "bow"
		@parent_plural = "bows"
		@can_shoot = true
		@available_as_child = false
	end

end

class Hammer < Inventory_weapon
		
	def initialize
		super("Megaton Hammer", "Hammer", "Hammers", 2, 0)
		@type = "hammer"
		@acquired_description = "This heavy hammer can be used to smash and break things! Use it with the commands \"hit\" and \"break\"."
		@parent_alias = true
		@parent_singular = "hammer"
		@parent_plural = "hammers"
		@available_as_child = false
	end
end

class Longshot < Hookshot
	
	def initialize
		super()
		@name = "Longshot"
		@acquired_description = "This is an ungraded Hookshot. It extends twice as far!"
		@range = 10
		@replace_previous = true
	end

end

class Fire_arrows < Inventory_weapon

end

class Ice_arrows < Inventory_weapon

end

class Inventory_ammo < Inventory_item

	attr_accessor :weapon_type, :spawn_frequency

	def initialize(name, gen_singular, gen_plural, weapon_type, quantity, spawn_frequency)
		super(name, gen_singular, gen_plural)
		@quantity_allowed = 1.0/0.0
		@weapon_type = weapon_type
		@quantity = quantity
		@can_roll_into = true
		@spawn_frequency = spawn_frequency
	end

	def add_to_weapon(inventory)
		item_found = false
		inventory.each do |item|
			if item.type == self.weapon_type
				item_found = true
				if item.display_item == false
					puts item.acquired_description
					item.display_item = true
				end
				if item.uses < item.max_uses
					new_val = item.uses + self.quantity
					if new_val < item.max_uses
						item.uses = new_val
					else
						puts "You now have the maximum number of #{self.gen_plural} you can carry."
						item.uses = item.max_uses
					end
				end
				break
			end
		end
		if item_found == false
			puts "But you don't have anything to store #{self.gen_plural} in."
		end
	end
end

class Deku_stick < Inventory_ammo
	
	def initialize
		super("Deku stick", "Deku stick", "Deku sticks", "stick", 1, 1)
		@parent_alias = true
		@parent_singular = "stick"
		@parent_plural = "sticks"
	end

end

class Deku_nuts < Inventory_ammo

	def initialize
		super("Deku nuts", "Deku nuts", "Deku nuts", "nut", 5, 3)
		@parent_alias = true
		@parent_singular = "nuts"
		@parent_plural = "nuts"
	end

end

class Arrows < Inventory_ammo

	def initialize
		super("arrows", "arrows", "arrows", "bow", 10, 4)
	end
end

class Bombs < Inventory_ammo

	def initialize
		super("bombs", "bombs", "bombs", "bomb", 5, 4)
	end
end

class Deku_seeds < Inventory_ammo

	def initialize
		super("Deku seeds", "Deku seeds", "Deku seeds", "slingshot", 5, 4)
		@parent_alias = true
		@parent_singular = "seeds"
		@parent_plural = "seeds"
	end
end

class Bottle < Inventory_item

end