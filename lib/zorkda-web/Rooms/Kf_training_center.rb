class Kf_training_center < Room

	def initialize
		super()
		@name = "Training Center"
		@description = "Around you stands various training supplies."
		@location = "Kokiri Forest"
		@sside = Crawlway.new("south")
		@nside = Pathway.new("north")
		@eside.change_type(:wooden_fence)
		@wside.change_type(:trees)
		@inventory = [Grass.new(nil, nil, 0, "RNG"), Grass.new(nil, nil, 0, "RNG"), Rock.new(nil, nil, 0, "RNG"), Rock.new(nil, nil, 0, "RNG"), Rock.new(nil, nil, 0, "RNG")]
		@characters = [Kf_training_center_kokiri.new]
	end

end