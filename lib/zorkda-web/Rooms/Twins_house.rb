class Twins_house < Room

	def initialize
		super()
		@name = "House of Twins"
		@description = "You stand in a small, humble treehouse with two beds in it."
		@wside = Door.new("west")
		@nside.change_type(:wooden_wall)
		@sside.change_type(:wooden_wall)
		@eside.change_type(:wooden_wall)
		@uside.change_type(:ceiling)
		@inventory = [Pot.new(nil, nil, 0, "RNG"), Pot.new(nil, nil, 0, "RNG")]
		@characters = [House_of_twins_kokiri.new]
	end
end