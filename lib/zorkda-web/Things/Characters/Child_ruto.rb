class Child_Ruto < Character

	def initialize
		super("Ruto", "A young Zora girl named Ruto stands in front of you", "Zora", 0, "Ruto", "Rutos")
		@can_pick_up = true
		@parent_alias = true
		@parent_singular = "girl"
		@parent_plural = "girls"
	end

	def pick_up(game_status)
		game_status.player.carrying = self
		game_status.characters.delete(self)
	end
end