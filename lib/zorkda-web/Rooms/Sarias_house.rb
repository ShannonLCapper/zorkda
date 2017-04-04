class Sarias_house < Room

	def initialize
		super()
		@name = "Saria's House"
		@description = "You stand in a small, humble treehouse prettily decorated with purple fabric."
		@nside = Door.new("north")
		@wside.change_type(:wooden_wall)
		@sside.change_type(:wooden_wall)
		@eside.change_type(:wooden_wall)
		@uside.change_type(:ceiling)
		@inventory = [Heart.new(nil, nil, 0), Heart.new(nil, nil, 0), Heart.new(nil, nil, 0), Heart.new(nil, nil, 0)]
	end
end