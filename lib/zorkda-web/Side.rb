class Side
	attr_accessor :direction, :permeable, :distance, :original_distance, :on_fire, :frozen,
	:display

	def initialize(direction)
		@direction = direction
		@permeable = false
		@distance = 0
		@original_distance = distance
		@on_fire = false
		@frozen = false
		@display = true
	end

	def set_distance(distance)
		self.distance = distance
		self.original_distance = distance
	end
end


class Barrier < Side
	
	@@errors = {
		:wooden_wall => "There's just a wooden wall there.", 
		:stone_wall => "There's just a stone wall there.", 
		:ceiling => "That's just the ceiling.", 
		:sky => "That's just the sky.",
		:air => "There's no way to get up from here.",
		:floor => "That's just the floor.", 
		:trees => "Dense trees block your path.",
		:wooden_fence => "A wooden fence is in the way.",
		:cliff_bottom => "A steep cliffside looms above you.",
		:cliff_top => "Unless you want to fall off a cliff, that is.",
		:counter => "You'd smack into the counter."
	}

	attr_accessor :error

	def initialize(direction, type)
		super(direction)
		@error = @@errors[type]
		@display = false
	end

	def give_collision_error
		puts "You can't go that way. #{self.error}"
	end

	def change_type(type)
		self.error = @@errors[type]
	end
end


class Path < Side

	attr_accessor :goes_to, :description, :plural_description

	def initialize(direction, description)
		super(direction)
		@description = description
		@plural_description = description
		@permeable = true
		@goes_to = nil
	end

	def give_description
		if self.direction == "up"
			print "Going upward, "
		elsif self.direction == "down"
			print "Below you, "
		else
			print "To the #{self.direction}, "
		end
		puts "#{self.description}."
	end
end

class Pathway < Path

	def initialize(direction)
		super(direction, "there is a pathway")
		@plural_description = "there are pathways"
	end
end

class Opening < Path
	def initialize(direction)
		super(direction, "there is an opening")
		@plural_description = "there are openings"
	end
end

class Cubby < Path

	def initialize(direction)
		super(direction, "there is a cubby")
		@plural_description = "there are cubbies"
	end
end

class Crawlway < Path

	def initialize(direction)
		super(direction, "there is a small crawl space")
		@plural_description = "there are small crawl spaces"
	end
end

class Door < Path

	def initialize(direction)
		super(direction, "there is a door")
		@plural_description = "there are doors"
	end
end

class High_door < Path

	def initialize(direction)
		super(direction, "there is a door set high in the wall")
		@plural_description = "there are doors set high the walls"
		@distance = 1
		@original_distance = 1
	end
end

class High_ledge < Path

	def initialize(direction)
		super(direction, "there is a high ledge")
		@plural_description = "there are high ledges"
		@distance = 1
		@original_distance = 1
	end
end

class Dropoff < Path

	def initialize(direction)
		super(direction, "there is a short dropoff")
		@plural_description = "there are short dropoffs"
	end
end

class Ladder < Path

	def initialize(direction)
		super(direction, "there is a ladder")
		@plural_description = "there are ladders"
	end
end

class Vines < Path

	def initialize(direction)
		super(direction, "there are some vines")
		@plural_description = "there are vines"
	end
end

class Waterway < Path

	attr_accessor :submerged_distance

	def initialize(direction, submerged_distance)
		super(direction, "there is an underwater passageway")
		@plural_description = "there are underwater passageways"
		@submerged_distance = submerged_distance
	end
end

class Blockable_path < Path

	attr_accessor :blocked, :blocked_desc, :unblocked_desc, :blocked_damage, :blocked_attempt_message,
	:blocked_plural_desc, :unblocked_plural_desc

	def initialize(direction, blocked_desc, unblocked_desc, blocked, blocked_attempt_message)
		@blocked_desc = blocked_desc
		@unblocked_desc = unblocked_desc
		@blocked = blocked
		if blocked
			super(direction, blocked_desc)
		else
			super(direction, unblocked_desc)
		end
		@blocked_damage = 0
		@blocked_attempt_message = blocked_attempt_message
		@blocked_plural_desc = nil
		@unblocked_plural_desc = nil
	end

	def unblock
		self.blocked = false
		self.description = self.unblocked_desc
		if self.unblocked_plural_desc.nil?
			self.plural_description = self.description
		else
			self.plural_description = self.unblocked_plural_desc
		end
	end

	def block
		self.blocked = true
		self.description = self.blocked_desc
		if self.blocked_plural_desc.nil?
			self.plural_description = self.description
		else
			self.plural_description = self.blocked_plural_desc
		end
	end

	def update_plural_desc
		if self.blocked
			self.plural_description = self.blocked_plural_desc
		else
			self.plural_description = self.unblocked_plural_desc
		end
	end
end

class Breakable_side < Blockable_path

	def initialize(direction)
		super(direction, "there is a wall that looks a little fragile", 
			  "there is an opening", true, "The wall seems crumbly, but it's still a wall.")
		@blocked_plural_desc = "there are walls that look rather fragile"
		@unblocked_plural_desc = "there are openings"
		update_plural_desc
	end
end

class Lockable_door < Blockable_path

	def initialize(direction)
		super(direction, "there is a locked door", "there is a door", 
			  true, "You try to open the door, but it's locked.")
		@blocked_plural_desc = "there are locked doors"
		@unblocked_plural_desc = "there are doors"
		update_plural_desc
	end
end

class Fallen_trunk_kokiri < Blockable_path

	def initialize(direction, blocked)
		super(direction, "there is a fallen tree trunk with a path running through it", 
			  "there is a fallen tree trunk with a path running through it", blocked, 
			  "The kokiri stands in front of you, blocking your way.")
		@blocked_plural_desc = "there are fallen tree trunks with paths running through them"
		@unblocked_plural_desc = "there are fallen tree trunks with paths running through them"
		update_plural_desc
	end
end

class Barrable_door < Blockable_path

	def initialize(direction, blocked)
		super(direction, "there is a barred door", "there is a door", blocked, 
			  "The door is blocked by heavy bars.")
		@blocked_plural_desc = "there are barred doors"
		@unblocked_plural_desc = "there are doors"
		update_plural_desc
	end
end

class Spider_ladder < Blockable_path

	def initialize(direction)
		super(direction, "there is a ladder with a skulwalltula crawling on it", 
			  "there is a ladder", true, 
			  "You try to climb the ladder, but you hit the skullwalltula and you're thrown back.")
		@blocked_damage = 0.5
		@blocked_plural_desc = "there are ladders with skullwalltulas crawling on them"
		@unblocked_plural_desc = "there are ladders"
		update_plural_desc
	end
end

class Spider_vines < Blockable_path

	def initialize(direction)
		super(direction, "there are vines with a skullwalltula crawling on them", 
			  "there are some vines", true, 
			  "You try to climb the vines, but you hit the skullwalltula and you're thrown back.")
		@blocked_damage = 0.5
		@blocked_plural_desc = "there are vines with skullwalltulas crawling on them"
		@unblocked_plural_desc = "there are vines"
		update_plural_desc
	end
end

class Fire_path < Blockable_path

	def initialize(direction, blocked)
		super(direction, "there is a path blocked by a pillar of fire", "there is a path", blocked, 
			  "You try to pass through the fire, but you get thrown back. Say goodbye to your eyebrows.")
		@blocked_damage = 0.5
		@on_fire = true
		@blocked_plural_desc = "there are paths blocked by pillars of fire"
		@unblocked_plural_desc = "there are paths"
		update_plural_desc
	end
end

class Spider_door < Blockable_path

	def initialize(direction)
		super(direction, "there is a door blocked by a Skulltula", "there is a door", 
			  true, "You try to reach the door, but the Skulltula throws you backward.")
		@blocked_damage = 0.5
		@blocked_plural_desc = "there are doors blocked by Skulltulas"
		@unblocked_plural_desc = "there are doors"
		update_plural_desc
	end
end

class Spider_high_door < Blockable_path

	def initialize(direction)
		super(direction, "there is a high door blocked by a Skulltula", 
			  "there is a door set high in the wall", true, 
			  "You try to reach the door, but the Skulltula throws you backward.")
		@blocked_damage = 0.5
		@distance = 1
		@original_distance = 1
		@blocked_plural_desc = "there are high doors blocked by Skulltulas"
		@unblocked_plural_desc = "there are doors set high in the walls"
		update_plural_desc
	end
end

class Spider_cubby < Blockable_path

	def initialize(direction)
		super(direction, "there is a cubby blocked by a Skulltula", "there is a cubby", 
			  true, "You try to reach the cubby, but the Skulltula throws you backward.")
		@blocked_damage = 0.5
		@blocked_plural_desc = "there are cubbies blocked by Skulltulas"
		@unblocked_plural_desc = "there are cubbies"
		update_plural_desc
	end
end

class Spider_high_cubby < Blockable_path

	def initialize(direction)
		super(direction, "there is a high cubby blocked by a Skulltula", "there is a high cubby", 
			  true, "You try to reach the cubby, but the Skulltula throws you backward.")
		@blocked_damage = 0.5
		@distance = 1
		@original_distance = 1
		@blocked_plural_desc = "there are high cubbies blocked by Skulltulas"
		@unblocked_plural_desc = "there are high cubbies"
		update_plural_desc
	end
end

class Blockable_water_path < Blockable_path

	attr_accessor :submerged_distance

	def initialize(direction, blocked, submerged_distance)
		super(direction, "there is a blocked underwater passageway", 
			  "there is an underwate passageway", blocked, 
			  "You try to go that way, but your path is blocked.")
		@submerged_distance = submerged_distance
		@blocked_plural_desc = "there are blocked underwater passageways"
		@unblocked_plural_desc = "there are underwater passageways"
		update_plural_desc
	end
end