class Kf_sw_kokiri < Character

	def initialize
		super("Kokiri girl", nil, "Kokiri", 0, "Kokiri girl", "Kokiri girls")
		@parent_alias = true
		@parent_singular = "girl"
		@parent_plural = "girls"
	end

	def dialogue(game_status)
		if self.talked_to_checkpoints.length == 0
			self.talked_to_checkpoints << game_status.checkpoint
			return "Oh, a fairy finally came to you! Now you have a lot to learn!
The best place to go to learn some new skills is in the Training Center.
It's on the hill just above here."
		else
			return "The best place to go to learn some new skills is in the Training Center.
It's on the hill just south of here."
		end
	end

end