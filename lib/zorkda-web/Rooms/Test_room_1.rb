class Test_room_1 < Room

	def initialize
		super()
		@name = "Test Room 1"
		@nside = Vines.new("north")
		@wside = Vines.new("west")
		@eside = Door.new("east")
		@sside = Door.new("south")
		@uside = Vines.new("up")
	end

end