class Kf_sw < Room

	def initialize
		super()
		@name = "Southwest"
		@description = "You stand in front of the Know It All Brothers' house.
A sign points south that reads \"Kokiri Training Center this way\"."
		@location = "Kokiri Forest"
		@nside = Pathway.new("north")
		@sside = Pathway.new("south")
		@wside = Door.new("west")
		@eside = Pathway.new("east")
		@characters = [Kf_sw_kokiri.new]
	end

end