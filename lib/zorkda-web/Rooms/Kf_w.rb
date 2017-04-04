class Kf_w < Room

	def initialize
		super()
		@name = "West"
		@location = "Kokiri Forest"
		@description = nil
		@nside = Pathway.new("north")
		@sside = Pathway.new("south")
		@eside = Pathway.new("east")
		@wside = Fallen_trunk_kokiri.new("west", true)
		@characters = [Kf_w_kokiri.new]
	end
end