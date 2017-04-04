class Kf_s < Room

	def initialize
		super()
		@name = "South"
		@description = "You stand at the roots of your treehouse. The village of Kokiri Forest stretches around you."
		@location = "Kokiri Forest"
		@nside = Pathway.new("north")
		@sside.change_type(:trees)
		@eside = Pathway.new("east")
		@wside = Pathway.new("west")
		@uside = Ladder.new("up")
		@characters = [Saria.new]
	end
end