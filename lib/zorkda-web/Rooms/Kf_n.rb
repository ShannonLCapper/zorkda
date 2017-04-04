class Kf_n < Room

	def initialize
		super()
		@name = "North"
		@description = nil
		@location = "Kokiri Forest"
		@wside = Pathway.new("west")
		@sside = Pathway.new("south")
		@eside = Pathway.new("east")
		@nside = Fallen_trunk_kokiri.new("north", true)
		@inventory = [Grass.new(nil, nil, 0, "RNG")]
		@characters = [Kf_w_kokiri.new]
	end
end