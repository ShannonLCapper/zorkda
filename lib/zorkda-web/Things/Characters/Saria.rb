class Saria < Character

	def initialize
		super("Saria", "Saria stands before you, her fairy floating around her head",
			"Kokiri", 0, "Saria", "Sarias")
		@parent_alias = true
		@parent_singular = "girl"
		@parent_plural = "girls"
	end

	def dialogue(game_status)
		checkpoint = game_status.checkpoint
		name = game_status.player.name
		if checkpoint < 2 && (!self.talked_to_checkpoints.include?(0) && !self.talked_to_checkpoints.include?(1))
			self.talked_to_checkpoints << checkpoint
			return "Wow! A fairy!!
Finally, a fairy came to you, #{name}!
Wow! That's great news! I'm so happy for you!
Now you're a true Kokiri, #{name}!

Is that right? The Great Deku Tree has summoned you?
It's quite an honor to talk to the Great Deku Tree!
I'll wait for you here. Get going! Go see the Great Deku Tree!"
		elsif checkpoint < 2
			return "I'll wait for you here. Get going! Go see the Great Deku Tree!"
		else
			return "I don't know what to say."
		end
	end
end