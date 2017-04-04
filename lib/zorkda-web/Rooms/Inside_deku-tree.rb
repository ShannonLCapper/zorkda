class Inside_deku_tree < Room

	def initialize(floor, name)
		super()
		@name = name
		@floor = floor
		@description = nil
		@location = "Inside the Deku Tree"
		@nside.change_type(:wooden_wall)
		@sside.change_type(:wooden_wall)
		@eside.change_type(:wooden_wall)
		@wside.change_type(:wooden_wall)
		@uside.change_type(:ceiling)
	end

end

class Idt_f1_main < Inside_deku_tree

	def initialize
		super("F1", "Main Trunk")
		@description = "You stand on the ground floor of a massive tree trunk."
		@wside = Opening.new("west")
		@uside = Ladder.new("up")
		@dside = Blockable_path.new(
			"down",
			"there is a large hole covered in thick spiderweb",
			"there is a large hole",
			true,
			"The thick spiderweb stretches, but does not give way.")
		@inventory = [Spiderweb.new(nil, nil, 0), Weed.new(nil, nil, 0, "RNG"), Weed.new(nil, nil, 0, "RNG"),Weed.new(nil, nil, 0, "RNG")]
		@inventory[0].display = false
		@enemies = [Deku_baba.new(nil, nil, 0), Deku_baba.new(nil, nil, 0), Deku_baba.new(nil, nil, 0)]
		@has_entry_cutscene = true
		@navi_hint = "Look, look! 
I think there's a tunnel below this web on the floor."
	end

	def entry_cutscene(game_status)
		dialogue = "You walk through the Deku Tree's mouth and enter a massive circular room. 
The walls are made of bark, and vines and spiderwebs hang from the tall ceiling.
When you look up, you can see several more floors above your head."
		stream_dialogue(dialogue)
	end

end

class Idt_f2_main < Inside_deku_tree

	def initialize
		super("F2", "Main Trunk")
		@description = "You stand on a narrow pathway along the perimeter of the trunk."
		@dside = Ladder.new("down")
		@uside = Spider_vines.new("up")
		@wside = Door.new("west")
		@inventory = [Chest.new(nil, nil, 0, [Yellow_rupee.new(nil, nil, 0)]), Weed.new(nil, nil, 0, "RNG"), Weed.new(nil, nil, 0, "RNG")]
		@enemies = [Skullwalltula.new(nil, nil, 5)]
		@enemies[0].display = false
		@navi_hint = "Those vines look pretty sturdy. Maybe you can climb them with \"go up\"."
	end

	def update_locks(game_status)
		if self.enemies.length == 0 && self.uside.blocked
			puts "You can now go up the vines."
			self.uside.unblock
		end
	end

	def update_navi_hint(game_status)
		if self.visited_before
			self.navi_hint = nil
		end
	end
end

class Idt_f2_2 < Inside_deku_tree

	def initialize
		super("F2", "Corridor")
		@description = "You stand in a narrow corridor."
		@wside = Barrable_door.new("west", false)
		@eside = Barrable_door.new("east", false)
		@enemies = [Deku_scrub.new(nil, "A deku scrub watches you from the middle of the room, its body buried in bushes.", 0)]
		@enemies[0].random_contents = false
		@enemies[0].contents = [Heart.new(nil, nil, false)]
	end

	def update_locks(game_status)
		if self.enemies.length == 0 && self.wside.blocked
			puts "The bars lift from the doors."
			self.wside.unblock
			self.eside.unblock
		elsif self.enemies.length > 0 && !self.wside.blocked
			puts "Heavy bars slam over both doors."
			self.wside.block
			self.eside.block
		end
	end
end

class Idt_f2_3 < Inside_deku_tree

	attr_accessor :ladder

	def initialize
		super("F2", "Small Room")
		@description = "You're in a small dead-end room."
		@eside = High_door.new("east")
		@inventory = [
			Chest.new("big chest", "A big chest sits in the center of the room.", 0, [Slingshot.new]),
			Ladder_switch.new,
			Weed.new(nil, nil, 0, [Deku_seeds.new]),
			Weed.new(nil, nil, 0, [Deku_seeds.new]),
			Weed.new(nil, nil, 0, [Heart.new(nil, nil, 0)]),
			Weed.new(nil, nil, 0, [Heart.new(nil, nil, 0)])
		]
		@ladder = @inventory[1]
		@navi_hint = "Look! Something is hanging up in that spiderweb by the door.
It looks like an old ladder! But how can we get it down?"
	end

	def update_distances(game_status)
		if self.ladder.activated && self.eside.distance != 0
			puts "You can now reach the east door."
			self.eside.distance = 0
			self.navi_hint = nil
		end
	end
end

class Idt_f3_landing < Inside_deku_tree

	def initialize
		super("F3", "Landing")
		@description = "You're on a cramped wooden landing coated in spiderwebs."
		@dside = Vines.new("down")
		@wside = Opening.new("west")
	end
end

class Idt_f3_main < Inside_deku_tree

	def initialize
		super("F3", "Main Trunk")
		@description = "You stand on a narrow pathway at the top of the Deku Tree's interior."
		@dside = Blockable_path.new(
			"down",
			"you can see all the way to the first floor. Sure seems like a big drop from here..",
			"you can see all the way to the first floor. Sure seems like a big drop from here..",
			true,
			"You try to pass the Skulltula, but it attacks you and knocks you back."
		)
		@dside.blocked_damage = 0.5
		@eside = Opening.new("east")
		@wside = Door.new("west")
		@enemies = [Skulltula.new(nil, "A Skulltula hangs between you and the drop-off.", 0)]
	end

	def update_locks(game_status)
		if self.dside.blocked && self.enemies.length == 0
			puts "The spider is no longer blocking the drop down."
			@dside.unblock
		elsif !self.dside.blocked && self.enemies.length > 0
			@dside.block
		end
	end
end

class Idt_f3_2 < Inside_deku_tree

	attr_accessor :switch, :torch, :spider, :platforms_up

	def initialize
		super("F3", "Platform Room")
		@description = "You stand at the bottom of a ditch in the room."
		@eside = Barrable_door.new("east", false)
		@sside = Spider_high_cubby.new("south")
		@inventory = [
			Torch.new("right torch", nil, 0, true),
			Torch.new("left torch", nil, 0, false),
			Floor_switch_sticky.new(nil, "There is a switch on the floor nearby.", 0, 1, 4),
			Chest.new("far chest", "A chest sits on the high land at the far end of the room.", 1, [Yellow_rupee.new(nil, nil, 0)]),
			Weed.new(nil, nil, 1, "RNG"),
			Weed.new(nil, nil, 1, "RNG")
		]
		@switch = @inventory[2]
		@torch = @inventory[1]
		@enemies = [
			Withered_deku_baba.new(nil, "A withered deku baba grows next to the chest.", 1),
			Skulltula.new(nil, nil, 1)
		]
		@spider = @enemies[1]
		@spider.respawn = false
		@spider.display = false
		@platforms_up = false
		@navi_hint = "It looks like that torch on the left was burning not too long ago."
	end

	def update_locks(game_status)
		if self.torch.on_fire && self.eside.blocked
			puts "The bars lift from the east door."
			self.eside.unblock
			self.navi_hint = nil
		elsif !self.torch.on_fire && !self.eside.blocked
			puts "Heavy bars slam over the east door."
			self.eside.block
		end
		if self.sside.blocked && !self.enemies.include?(self.spider)
			puts "The south door is now spider free."
			self.sside.unblock
		elsif !self.sside.blocked && self.enemies.include?(self.spider)
			self.sside.block
		end
	end

	def update_distances(game_status)
		move_counter = game_status.move_counter
		if self.switch.activated && !self.platforms_up
			puts "Platforms rise from the ditch."
			self.platforms_up = true
			self.move_all_closer
		elsif !self.switch.activated && self.platforms_up
			self.platforms_up = false
			puts "The platforms sink back into the ditch."
			self.move_all_farther_if_needed
		end
	end

end

class Idt_f3_cubby < Inside_deku_tree

	def initialize
		super("F3", "Cubby")
		@description = "You stand in a small cubby in the wall."
		@nside = Opening.new("north")
		@inventory = [Chest.new("small chest", nil, 0, [Heart.new(nil, nil, 0)])]
		@enemies = [Gold_skulltula.new(nil, "A gold skulltula crawls on the wall", 0)]
	end
end

class Idt_basement < Room

	def initialize(floor, name)
		super()
		@name = name
		@floor = floor
		@description = nil
		@location = "Inside the Deku Tree"
		@uside.change_type(:ceiling)
	end
end

class Idt_b1_sewer_east < Idt_basement

	attr_accessor :torch, :chest, :corner_web, :switch, :door_web

	def initialize
		super("B1", "Sewer (East end)")
		@description = "You're standing in what looks like an old, damp sewer."
		@sside = Blockable_path.new("south", "there is a door coated in spiderwebs", "there is a door", true, "you try to push past the spiderwebs, but they are too thick.")
		@wside = High_ledge.new("west")
		@wside.set_distance(2)
		@uside = Vines.new("up")
		@has_entry_cutscene = true
		@inventory = [
			Floor_switch_sticky.new(nil, nil, 0, 1, 1.0/0.0), 
			Torch.new(nil, nil, 1, false),
			Chest.new(nil, nil, 1, [Heart.new(nil, nil, false)]),
			Spiderweb.new("corner spiderweb", "A spiderweb in the corner blocks off a chest and an unlit torch.", 0),
			Spiderweb.new("door spiderweb", nil, 0),
			Weed.new(nil, nil, 0, "RNG"),
			Weed.new(nil, nil, 0, "RNG")
		]
		@switch = @inventory[0]
		@torch = @inventory[1]
		@chest = @inventory[2]
		@corner_web = @inventory[3]
		@door_web = @inventory[4] 
		@torch.display = false
		@chest.display = false
		@door_web.display = false
		@enemies = [
			Gold_skulltula.new(nil, nil, 5),
			Gold_skulltula.new(nil, nil, 5),
			Deku_baba.new(nil, nil, 0)
		]
	end

	def entry_cutscene(game_status)
		dialogue = "You plummet downward through the air with a scream.
You fall onto the thick spiderweb coating the floor on the ground level, 
and your momentum is sufficient to rip through the spiderweb.
You drop one more story and land in a pool of murky water."
		stream_dialogue(dialogue)
		game_status.child_rooms[:idt_f1_main].dside.unblock
		game_status.child_rooms[:idt_f1_main].navi_hint = nil
	end

	def update_distances(game_status)
		# if self.wside.distance == 1
		# 	self.inventory.each do |item|
		# 		if item.is_a?(Block)
		# 			self.wside.distance = 0
		# 			break
		# 		end
		# 	end
		# end
		if self.switch.activated && !self.torch.on_fire
			puts "The torch flares to life, burning away the spiderweb in the corner."
			self.torch.display = true
			self.chest.display = true
			self.move_all_closer
			self.inventory.delete(self.corner_web)
			suppress_output{ self.torch.light(game_status) }
		end
	end

	def update_locks(game_status)
		if !self.inventory.include?(self.door_web) && self.sside.blocked
			puts "You can now go south."
			self.sside.unblock
		end
	end

end

class Idt_b1_2 < Idt_basement

	def initialize
		super("B1", "Round Room")
		@description = "You stand in a round stone room."
		@nside = Door.new("north")
		@wside = Barrable_door.new("west", false)
		@inventory = [
			Eye_switch.new(nil, "Above the west door, there is a metal eye switch", 5, 1.0/0.0),
			Weed.new(nil, nil, 0, Heart.new(nil, nil, false)),
			Weed.new(nil, nil, 0, "RNG")
		]
		@enemies = [
			Talking_deku_scrub.new(nil, "A deku scrub watches from the center of the room.", 0, 
"Wait! Plesae forgive me, master! I'll never do it again!
If you spare me, I'll teach you something cool.

You will never beat my brothers up ahead unless you punish them in the proper order.
The order is... 2    3    1
Twenty-three is number one!
Do you think I'm a traitor?"
			)
		]
		@enemies[0].respawn = true
	end

	def update_locks(game_status)
		if self.inventory[0].activated && self.wside.blocked
			puts "The bars lift from the west door."
			self.wside.unblock
		elsif !self.inventory[0].activated && !self.wside.blocked
			puts "Heavy bars slam over the west door."
			self.wside.block
		end
	end

end

class Idt_b1_3_east < Idt_basement

	def initialize
		super("B1", "Spiked Log Room (East end)")
		@description = "You stand at the east end of a room separated by a moat.
A platform floats back and forth across the moat, passing underneath a sharp spiked log."
		@eside = Door.new("east")
		@wside = Blockable_path.new("west", "there is a ledge reachable only via the platform", 
			"there is ledge reachable only via the platform", 
			true,
			"You try to ride the platform across the moat.
But the spiked log knocks you off as you pass beneath it.")
		@wside.blocked_damage = 0.5
		@inventory = [Floor_switch_sticky.new(nil, "It looks like there might be a floor switch under the water", 0, 1, 2)]
		@inventory[0].submerged = true
		@navi_hint = "If you see something submerged, you can dive for it with the command \"dive for <item>\".
I bet there are some interesting things down there!"
	end

	def update_locks(game_status)
		if self.inventory[0].activated && self.wside.blocked
			puts "The water level drops, allowing more space between the floating platform and the spiked log."
			@wside.unblock
		elsif !self.inventory[0].activated && !self.wside.blocked
			puts "The water returns to its original height."
		end
	end

	def update_navi_hint(game_status)
		if self.inventory[0].activated
			self.navi_hint = nil
		end
	end
end

class Idt_b1_3_west < Idt_basement

	attr_accessor :blok

	def initialize
		super("B1", "Spiked Log Room (West end)")
		@description = "You stand on a ledge at the west end of a room separated by a moat."
		@wside = High_door.new("west")
		@eside = Path.new("east", "there is land you can easily swim to")
		@navi_hint = "Blocks can be moved with the command \"push block\"."
		@inventory = [
			Block.new(nil, "A block sits a small distance from the west wall.", "A block sits against the west wall.", 0, true, false),
			Weed.new(nil, nil, 0, "RNG"),
			Weed.new(nil, nil, 0, "RNG")
		]
		@blok = @inventory[0]
		@enemies = [Skulltula.new(nil, "A Skulltula hangs between the block and the wall.", 0)]
		@enemies[0].respawn = false
	end

	def update_navi_hint(game_status)
		if self.blok.slid
			self.navi_hint = nil
		end
	end

	def update_distances(game_status)
		if self.enemies.length == 0 && !self.blok.path_clear
			self.blok.path_clear = true
		end
		if self.blok.slid && self.wside.distance > 0
			move_all_closer
		elsif !self.blok.slid && self.wside.distance == 0
			move_all_farther_if_needed
		end
	end
end

class Idt_b1_4 < Idt_basement

	def initialize
		super("B1", "Torch Room")
		@description = nil
		@eside = Barrable_door.new("east", false)
		@nside = Barrable_door.new("north", false)
		@inventory = [
			Torch.new("big torch", nil, 0, true),
			Torch.new("small torch 1", nil, 0, false),
			Torch.new("small torch 2", nil, 0, false),
			Weed.new(nil, nil, 0, "RNG")
		]
		@enemies = [
			Deku_baba.new(nil, nil, 0),
			Withered_deku_baba.new(nil, nil, 0)
		]
	end

	def update_locks(game_status)
		if self.inventory[1].on_fire && self.inventory[2].on_fire && self.eside.blocked
			puts "The bars lift from both doors."
			self.eside.unblock
			self.nside.unblock
		elsif !self.inventory[1].on_fire && !self.inventory[2].on_fire && !self.eside.blocked
			puts "Heavy bars slam over both doors."
			self.eside.block
			self.nside.block
		end
	end
end

class Idt_b1_5 < Idt_basement

	attr_accessor :wall, :web

	def initialize
		super("B1", "Larva Room")
		@description = "You stand in a large spiderweb-coated room with a musty sort of smell."
		@eside = Blockable_path.new("east", "there is a small crawl space with a spiderweb over the opening", "there is a small crawl space", true, "The spiderweb over the opening is too thick to go through.")
		@sside = Door.new("south")
		@nside = Breakable_side.new("north")
		@inventory = [
			Breakable_wall.new("north", 0),
			Spiderweb.new("spiderweb over the crawl space", nil, 0),
			Torch.new(nil, nil, 0, true),
			Weed.new(nil, nil, 0, "RNG")
		]
		@web = @inventory[1]
		@wall = @inventory[0]
		@web.display = false
		@enemies = [
			Gohma_egg.new(nil, "A grotesque Gohma egg lays on the floor, pulsating.", 0),
			Gohma_egg.new(nil, nil, 0),
			Gohma_egg.new(nil, nil, 0),
			Withered_deku_baba.new(nil, nil, 0)			
		]
	end

	def update_locks(game_status)
		if !self.inventory.include?(self.wall) && self.nside.blocked
			self.nside.unblock
		end
		if !self.inventory.include?(self.web) && self.eside.is_a?(Blockable_path) && self.eside.blocked
			self.eside = Crawlway.new("east")
			self.eside.goes_to = game_status.child_rooms[:idt_b1_sewer_west]
		end
	end

end

class Idt_b1_sewer_west < Idt_basement

	attr_accessor :web, :blok

	def initialize
		super("B1", "Sewer (West end)")
		@description = "You are standing in what looks like an old, damp sewer."
		@wside = Crawlway.new("west")
		@eside = Dropoff.new("east")
		@dside = Blockable_path.new(
			"down",
			"there is a large hole covered in thick spiderweb",
			"there is a large hole",
			true,
			"The thick spiderweb stretches, but does not give way.")
		@inventory = [
			Spiderweb.new("spiderweb over the large hole", nil, 0),
			Block.new(nil, "A block sits a short distance from the dropoff.", "A block sits against the west ledge.", 0, false, true)
		]
		@web = @inventory[0]
		@blok = @inventory[1]
		@web.display = false
		@enemies = [
			Deku_baba.new(nil, nil, 0),
			Withered_deku_baba.new(nil, nil, 0)
		]
	end

	def update_locks(game_status)
		if self.inventory.include?(self.blok) && self.blok.slid
			puts "The block falls off the ledge, making a bridge between the east and west ends of the room."
			self.inventory.delete(self.blok)
			game_status.child_rooms[:idt_b1_sewer_east].inventory << self.blok
			game_status.child_rooms[:idt_b1_sewer_east].wside.distance = 0
		end
		if !self.inventory.include?(self.web) && self.dside.blocked
			puts "You can now go down."
			self.dside.unblock
		end
	end
end

class Idt_b2_antechamber < Idt_basement

	attr_accessor :stun_order

	def initialize
		super("B2", "Antechamber")
		@description = "You stand in a dimly room lit by flickering torches with a small pond at one end."
		@uside = Vines.new("up")
		@nside = Barrable_door.new("north", true)
		@inventory = [
			Heart.new(nil, nil, 0),
			Heart.new(nil, nil, 0),
			Heart.new(nil, nil, 0),
			Weed.new(nil, nil, 0, "RNG"),
			Weed.new(nil, nil, 0, "RNG"),
			Weed.new(nil, nil, 0, "RNG")
		]
		3.times do |i|
			@inventory[i].submerged = true
		end
		@enemies = [
			Deku_scrub_brother.new("Deku scrub 3"),
			Deku_scrub_brother.new("Deku scrub 2"),
			Deku_scrub_brother.new("Deku scrub 1")
		]
		@stun_order = []
	end

	def update_locks(game_status)
		self.enemies.each do |enemy|
			if enemy.stunned && !self.stun_order.include?(enemy)
				self.stun_order << enemy
			end
		end
		if self.stun_order == [self.enemies[1], self.enemies[0], self.enemies[2]]
			puts "\nDeku scrub 1 jumps out of hiding."
			print "Deku scrub 1: \""
			stream_dialogue("How did you know our secret?! How irritating!
It's so annoying that I'm going to reveal the secret of Queen Gohma to you!
In order to administer to coup de grace to Queen Gohma,
strike with your sword while she's stunned.

Oh, Queenie...
Sorry about that!")
			puts "\"\nAnd with that, the deku scrubs disappear, leaving a heart behind."
			self.enemies = []
			self.inventory << Heart.new(nil, nil, false)
			puts "The bars lift from the north door."
			self.nside.unblock
		elsif self.stun_order.length == 3
			self.enemies.each do |enemy|
				enemy.destun
			end
			puts "All three deku scrubs are no longer stunned."
			self.stun_order = []
		end
	end
end

class Idt_gohmas_lair < Idt_basement

	def initialize
		super(nil, "Gohma's Lair")
		@description = "You stand in a huge, cavernous room surrounded in mist."
		@has_entry_cutscene = true
		@enemies = [Gohma.new]
	end

	def entry_cutscene(game_status)
		dialogue = "You step through the doorway to enter a massive dark cave.
With a crash, a wall closes over the door behind you. You're trapped.

You look around, squinting to try to make out anything in the darkness.
Mist fills the room, but other than that it seems empty.
That's when you hear rustling noises coming from above you.

Filled with dread, you look up.
A massive hairy spider with a single bulging eye looks back.

Gohma, the giant parasitic arachnid, hurls herself to the ground in front of you.
She looms over you and lets out a bloodcurdling bellow, then crawls back up to the ceiling."
		stream_dialogue(dialogue)
	end
end