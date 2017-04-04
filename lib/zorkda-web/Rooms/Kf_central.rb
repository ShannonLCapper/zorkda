class Kf_central < Room

	def initialize
		super()
		@name = "Central"
		@description = "A signpost reads: \"North: Lost Woods, West: Hyrule Field, East: Great Deku Tree\""
		@location = "Kokiri Forest"
		@nside = Pathway.new("north")
		@sside = Pathway.new("south")
		@wside = Pathway.new("west")
		@eside = Pathway.new("east")
		@inventory = [Blue_rupee.new(nil, "a blue rupee lies at the base of the sign", false)]
		@characters = [Kf_central_kokiri.new]
	end

end