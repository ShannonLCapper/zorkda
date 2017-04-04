class Kf_shop < Room

	def initialize
		super()
		@name = "Kokiri Shop"
		@description = nil
		@nside.change_type(:counter)
		@sside = Door.new("south")
		@eside.change_type(:wooden_wall)
		@wside.change_type(:wooden_wall)
		@uside.change_type(:ceiling)
		@characters = [Kokiri_shopkeeper.new]
	end
end