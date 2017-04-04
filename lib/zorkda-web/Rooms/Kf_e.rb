class Kf_e < Room

	def initialize
		super()
		@name = "East"
		@location = "Kokiri Forest"
		@description = nil
		@nside = Pathway.new("north")
		@sside = Pathway.new("south")
		@wside = Pathway.new("west")
		@eside = Fallen_trunk_kokiri.new("east", true)
		@characters = [Mido.new]
	end

	def update_locks(game_status)
		if self.characters.length > 0
			mido = self.characters[0]
			if mido.moved && self.eside.blocked
				puts "Mido petulantly stomps out of the way. Now you can go east."
				self.eside.unblock
			end
		end
	end
end