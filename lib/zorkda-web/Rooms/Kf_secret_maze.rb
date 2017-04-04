class Kf_secret_maze < Room

	def initialize
		super()
		@name = "???"
		@location = "Kokiri Forest Secret Maze"
		@nside.change_type(:trees)
		@sside.change_type(:trees)
		@eside.change_type(:trees)
		@wside.change_type(:trees)
	end
end

class Kf_sm_1 < Kf_secret_maze
	def initialize
		super()
		@nside = Crawlway.new("north")
		@eside = Pathway.new("east")
		@inventory = [Blue_rupee.new(nil, "a blue rupee lies on the ground", false), Weed.new(nil, "a weed grows in the center of the clearing", 0, "RNG")]
	end
end

class Kf_sm_2 < Kf_secret_maze
	def initialize
		super()
		@sside = Pathway.new("south")
		@eside = Pathway.new("east")
		@wside = Pathway.new("west")
	end
end

class Kf_sm_3 < Kf_secret_maze
	def initialize
		super()
		@sside = Pathway.new("south")
		@wside = Pathway.new("west")
		
	end
end

class Kf_sm_4 < Kf_secret_maze
	def initialize
		super()
		@nside = Pathway.new("north")
		@eside = Pathway.new("east")
		@inventory = [Blue_rupee.new(nil, nil, false), Weed.new(nil, nil, 0, "RNG")]
	end
end

class Kf_sm_5 < Kf_secret_maze
	def initialize
		super()
		@wside = Pathway.new("west")
		@nside = Pathway.new("north")
		@sside = Pathway.new("south")
	end
end

class Kf_sm_6 < Kf_secret_maze
	def initialize
		super()
		@nside = Pathway.new("north")
		@inventory = [Chest.new("large chest", "a large chest sits atop a tree stump", 0, [Kokiri_sword.new]), Weed.new(nil, nil, 0, "RNG")]
	end
end
