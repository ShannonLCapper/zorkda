class Equipment < Thing
	attr_accessor :name, :equipped, :type, :damage_enemy, :gen_singular, :gen_plural, :range, 
	:available_as_child, :available_as_adult, :parent_alias, :parent_singular,
	:parent_plural, :replace_previous, :description, :acquired_description, :susceptible_to_fire,
	:reflective, :strength, :weight, :heat_resistance, :underwater_breathing, :diving_distance, 
	:quantity_allowed, :quantity, :can_hit_things

	def initialize(name, type, gen_singular, gen_plural)
		super()
		@name = name
		@equipped = false
		@type = type
		@damage_enemy = 0
		@gen_singular = gen_singular
		@gen_plural = gen_plural
		@range = 0
		@available_as_child = true
		@available_as_adult = true
		@parent_alias = false
		@parent_singular = nil
		@parent_plural = nil
		@replace_previous = false
		@description = nil
		@can_pick_up = true
		@can_slide = false
		@flammable = false
		@hookshotable = false
		@respawn = false
		@acquired_description = nil
		@susceptible_to_fire = false
		@reflective = false
		@strength = 0
		@weight = 0
		@heat_resistance = 0
		@underwater_breathing = 0
		@diving_distance = 0
		@quantity_allowed = 1
		@quantity = 1
		@can_roll_into = true
		@can_hit_things = false
	end

	def use
	end

	def pick_up(game_status)
		game_status.player.add_to_protagonist(self)
		if self.respawn
			game_status.curr_room.respawn << self
		end
		game_status.curr_room.inventory.delete(self)
	end
	
end


class Scale < Equipment

	def initialize(name, diving_distance, gen_singular, gen_plural)
		super(name, "scale", gen_singular, gen_plural)
		@diving_distance = diving_distance
		@parent_alias = true
		@parent_singular = "scale"
		@parent_plural = "scales"
		@replace_previous = true
	end
end

class Silver_scale < Scale

	def initialize
		super("Silver Scale", 1, "Silver Scale", "Silver Scales")
		@acquired_description = "Use the command \"dive for\" to pick up items below water. You can dive deeper than you could before."
	end
end

class Golden_scale < Scale

	def initialize
		super("Golden Scale", 2, "Golden Scale", "Golden Scales")
		@acquired_description = "Use the command \"dive for\" to pick up items below water. 
Now you can dive much deeper than you could before."
	end
end

class Goron_bracelet < Equipment

	def initialize
		super("Goron bracelet", "bracelet", "bracelet", "bracelets")
		@acquired_description = "You can now pull up Bomb Flowers. Pick them up using the command \"pick up\".
Once you pick up a bomb flower, you have three more moves before it explodes."
		@strength = 1
		@available_as_adult = false
	end
end

class Gauntlets < Equipment

	def initialize(name, strength, gen_singular, gen_plural)
		super(name, "gauntlets", gen_singular, gen_plural)
		@strength = strength
		@available_as_child = false
		@parent_alias = true
		@parent_singular = "gauntlet"
		@parent_plural = "gauntlets"
		@replace_previous = true
	end
end

class Silver_gauntlets < Gauntlets

	def initialize
		super("Silver Gauntlets", 1, "Silver Gauntlets", "Silver Gauntlets")
		@acquired_description = "When you wear them, you feel power in your arms, the power to lift big things with the command \"pick up\".
But these guantlets won't fit a kid."
	end
end

class Golden_gauntlets < Gauntlets

	def initialize
		super("Golden Gauntlets", 2, "Golden Gauntlets", "Golden Gauntlets")
		@acquired_description = "You can feel even more power coursing through your arms! Lift things with the command \"pick up\"."
	end
end

class Shield < Equipment

	def initialize(name, available_as_adult, available_as_child, susceptible_to_fire, reflective)
		super(name, "shield", name, name + "s")
		@available_as_adult = available_as_adult
		@available_as_child = available_as_child
		@parent_alias = true
		@parent_singular = "shield"
		@parent_plural = "shields"
		@susceptible_to_fire = susceptible_to_fire
		@reflective = reflective
	end
end

class Deku_shield < Shield

	def initialize
		super("Deku Shield", false, true, true, false)
		@acquired_description = "Since it's made of wood, if you get hit with fire while it's equipped, it'll burn away.
You can use the shield with the command \"block\". "
	end
end

class Hylian_shield < Shield

	def initialize
		super("Hylian Shield", true, false, false, false)
		@acquired_description = "This sturdy shield is made of metal, so it won't burn. It's a bit too big for a kid to use."
	end
end

class Mirror_shield < Shield

	def initialize
		super("Mirror Shield", true, false, false, true)
		@acquired_description = "This shield's polished surface can reflect light or energy."
	end
end


class Boots < Equipment

	def initialize(name, weight, available_as_child)
		super(name, "boots", name, name)
		@available_as_child = available_as_child
		@weight = weight
		@parent_alias = true
		@parent_singular = "boot"
		@parent_plural = "boots"
	end
end

class Kokiri_boots < Boots

	def initialize
		super("Kokiri Boots", 0, true)
		@equipped = true
	end
end

class Iron_boots < Boots

	def initialize
		super("Iron Boots", 1, true)
		@acquired_description = "So heavy, you can't run. So heavy, you can't float."
	end
end


class Tunic < Equipment

	def initialize(name, available_as_child)
		gen_plural = "Tunics"
		super(name, "tunic", name, gen_plural)
		@available_as_child = available_as_child
		@parent_alias = true
		@parent_singular = "Tunic"
		@parent_plural = "Tunics"
	end
end

class Goron_tunic < Tunic

	def initialize		
		super("Goron Tunic", false)
		@heat_resistance = 1
		@acquired_description = "This heat-resistant tunic is adult size, so it won't fit a kid. Going to a hot place? No worry!"
	end
end

class Kokiri_tunic < Tunic

	def initialize
		super("Kokiri Tunic", true)
		@equipped = true
	end
end

class Zora_tunic < Tunic

	def initialize
		super("Zora Tunic", false)
		@underwater_breathing = 1
		@acquired_description = "This diving suit is adult size, so it won't fit a kid. Wear it, and you won't drown underwater."
	end
end


class Sword < Equipment

	attr_accessor :uses, :total_uses

	def initialize(name, damage_enemy, gen_singular, gen_plural, total_uses)
		super(name, "sword", gen_singular, gen_plural)
		@damage_enemy = damage_enemy
		@parent_alias = true
		@parent_singular = "sword"
		@parent_plural = "swords"
		@uses = total_uses
		@total_uses = total_uses
		@turns_into = nil
		@can_hit_things = true
		@can_cut_things = true
	end

	def use(game_status, target)
		player = game_status.player
		curr_room = game_status.curr_room
		sword_used = false
		if player.carrying != nil
			puts "Your hands are full with something else. Drop that before using your sword."
		elsif target.distance > self.range
			puts "That target is too far away to hit with your sword."
		elsif target.submerged && player.weight < 2
			puts "That target is underwater, and you can't use your sword while floating around."
		elsif target.is_a?(Character)
			puts "Uh, no. That would be murder."
		elsif target.effective_items == nil || (!target.effective_items.include?(self.type) && !target.stunned_by.include?(self.type))
			if target.is_a?(Enemy)
				puts "You hack away with the #{self.name}, but the enemy is unaffected by the attack."
			else
				puts "You hack away with the #{self.name}, but nothing happens to the #{target.name}."
			end
			sword_used = true
		else
			if target.is_a?(Enemy)
				target.get_hit(game_status, self.type, self.damage_enemy, "You swing your #{self.name} and injure the enemy.")
			elsif target.breakable
				target.break(curr_room, player)
			elsif target.cuttable
				target.cut(game_status)
			end
			sword_used = true
		end
		if sword_used
			self.uses -= 1
			if self.uses <= 0
				self.uses = 1.0/0.0
				puts "Your #{self.name} broke!"
				self.name = "Broken " + self.name
				self.damage_enemy /= 4
				self.gen_plural = self.gen_plural
				self.gen_singular = self.gen_singular
			end
		end
	end
end

class Kokiri_sword < Sword

	def initialize
		super("Kokiri Sword", 1, "Kokiri Sword", "Kokiri Swords", 1.0/0.0)
		@available_as_adult = false
		@acquired_description = "This is a hidden treasure of the Kokiri, but you can borrow it for a while.
You can use it with the commands \"hit\", \"break\", or \"cut\"."
	end
end

class Master_sword < Sword

	def initialize
		super("Master Sword", 2, "Master Sword", "Master Swords", 1.0/0.0)
		@available_as_child = false
		@description = "An elegant sword with a blue handle and gold inlay sits upright in a pedastal."
		@acquired_description = "This legendary sword is known as The Blade of Evil's Bane."
		@can_roll_into = false
	end
end

class Giants_knife < Sword

	def initialize
		super("Giant's Knife", 4, "Giants Knife", "Giants Knives", 8)
		@available_as_child = false
		@acquired_description = "This sword is so big, you have to use both hands to hold it and can't use your shield while it is equipped."
	end
end

class Biggorons_sword < Sword

	def initialize
		super("Biggoron's Sword", 4, "Biggorons Sword", "Biggorons Swords", 1.0/0.0)
		@available_as_child = false
		@acquired_description = "This blade was forged by a master smith and won't break!"
	end
end

