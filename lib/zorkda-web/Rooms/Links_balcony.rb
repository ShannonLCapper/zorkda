class Links_balcony < Room

	def initialize
		super()
		@name = "Link's Balcony"
		@description = nil
		@location = "Kokiri Forest"
		@nside.change_type(:wooden_fence)
		@sside = Door.new("south")
		@eside.change_type(:wooden_fence)
		@wside.change_type(:wooden_fence)
		@dside = Ladder.new("down")
		@has_entry_cutscene = true
	end

	def entry_cutscene(game_status)
		dialogue = "As you emerge from your treehouse, you look out into the clearing of Kokiri Forest.
This has been your home for as long as you can remember.
You see your friend, Saria, run towards you on the ground below.

Saria: \"Yahoo! Hi, #{game_status.player.name}!
Come on down and talk to me with the \"talk to\" command.\""
		stream_dialogue(dialogue)
	end

end