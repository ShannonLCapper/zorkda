class Links_house < Room

	def initialize
		super()
		@name = "Link's Room"
		@description = "You are in a small, cozy, one-room treehouse. 
Pictures of you and your friends, all clad in green tunics, are on the walls."
		@location = nil
		@nside = Door.new("north")
		@sside.change_type(:wooden_wall)
		@eside.change_type(:wooden_wall)
		@wside.change_type(:wooden_wall)
		@uside.change_type(:ceiling)
		@has_entry_cutscene = true
	end

	def entry_cutscene(game_status)
		dialogue = "\"In the vast deep forest of Hyrule...
Long have I served as the guardian spirit...
I am known as the Deku Tree...

The children of the forest, the Kokiri, live here with me.
Each Kokiri has his or her own guardian fairy.

However, there is one boy who does not have a fairy...\"
.
.
.
.
.
You shudder in your sleep, plagued with nightmares...

In your dream, you stand before a castle in the pouring rain.
The drawbridge opens, releasing a young girl who rides into the night on a white horse.
You look back to see a horrible man standing over you, clad in black armor astride a huge black stallion.
With a malicious glint in his eyes, he threateningly raises his hand toward you...
.
.
.
.
.
\"Navi...
Navi, where art thou?
Come hither...

Oh, Navi the fairy...
Listen to my words, the words of the Deku Tree...

Dost thou sense it?
The climate of evil descending upon this realm...
Malevolent forces even now are mustering to attack our land of Hyrule...
For so long, the Kokiri Forest, the source of life, has stood as a barrier,
deterring outsiders and maintaining the order of the world...

But... before this tremendous evil power, even my power is as nothing...

It seems the time has come for the boy without a fairy to begin his journey...
The youth whose destiny it is to lead Hyrule to the path of justice and truth...

Navi... go now! Find our young friend and guide him to me...
I do not have much time left.
Fly, Navi, fly! The fate of the forest, nay, the world, depends upon thee!\"


Navi flies away from the Great Deku Tree's glen, soaring over Kokiri Forest.
She greets a few of the Forest's inhabitants, the Kokiri, as she searches for one house in particular.
Finding it, she flits into the treehouse, finding you asleep in your bed.

Navi: \"Hello #{game_status.player.name}! Wake up!
The Great Deku Tree wants to talk to you!
#{game_status.player.name}, get up!\"

You don't budge from bed.

Navi: \"Hey! C'mon!
Can Hyrule's destiny really depend on such a lazy boy?\"

You begrudgingly awaken with a yawn, and sit up.

Navi: \"You finally woke up!
I'm Navi the fairy.
The Greak Deku Tree asked me to be your partner from now on. Nice to meet you!

The Greak Deku Tree has summoned you! So let's get going!
You can move around by typing \"go <direction>\".
If you need help, type \"help\".
To talk to me, type \"talk to Navi\" or just \"Navi\".\""
		stream_dialogue(dialogue)
	end

end