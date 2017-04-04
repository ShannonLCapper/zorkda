class Kf_se < Room

	def initialize
		super()
		@name = "Southeast"
		@description = "You stand in front of Saria's house and the House of Twins."
		@location = "Kokiri Forest"
		@nside = Pathway.new("north")
		@sside = Door.new("south")
		@wside = Pathway.new("west")
		@eside = Door.new("east")
		@inventory = [Grass.new(nil, nil, 0, "RNG"), Grass.new(nil, nil, 0, "RNG"), Grass.new(nil, nil, 0, "RNG"), Grass.new(nil, nil, 0, "RNG")]
		@characters = [Kf_se_kokiri.new]
	end

end