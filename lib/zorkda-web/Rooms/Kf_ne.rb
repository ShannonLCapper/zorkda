class Kf_ne < Room

	def initialize
		super()
		@name = "Northeast"
		@description = "You're standing in front of a tree-shaped building.
A sign above the door reads \"Kokiri Shop\"."
		@location = "Kokiri Forest"
		@nside = Door.new("north")
		@sside = Pathway.new("south")
		@wside = Pathway.new("west")
		@eside.change_type(:trees)
		@inventory = [Blue_rupee.new(nil, "you can see a blue rupee partially concealed behind the shop", false)]
	end

end