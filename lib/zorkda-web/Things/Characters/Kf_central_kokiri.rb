class Kf_central_kokiri < Character

	def initialize
		super("Kokiri girl", nil, "Kokiri", 0, "Kokiri girl", "Kokiri girls")
		@parent_alias = true
		@parent_singular = "girl"
		@parent_plural = "girls"
	end

	def dialogue(game_status)
		if self.talked_to_checkpoints.length == 0 && game_status.checkpoint < 2
			self.talked_to_checkpoints << game_status.checkpoint
			return "Oh, you have a fairy now?! That's great, #{game_status.player.name}!
What? You've been called by the Great Deku Tree?
What an honor!
He may give you a special gift! Tee hee!
That's because the Great Deku Tree is our father, the forest guardian,
and he gave life to all of us Kokiri!"
		else
			return "I wonder if the Great Deku Tree gave life to everying in the forest,
I mean in addition to us Kokiri?"
		end
	end
end