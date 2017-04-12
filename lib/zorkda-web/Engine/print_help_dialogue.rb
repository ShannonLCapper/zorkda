module Zorkda
	module Parser

		#THIS WILL BE MOVED TO THE GAME PAGE
		def print_help_dialogue(game_output)
			dialogue = [
				"Welcome to the Zork version of Legend of Zelda: Ocarina of Time.",
				"Here are some tips on how to use the command prompt.",
				" ",
				"COMMANDS:",
					
					"LOOK / L  :   gives you information about the room you are in

					NEXT / N / WAIT  :   moves time forward one frame
					
					HEALTH / HEARTS / H  :   shows you your health
					
					HEART PIECES  :   shows how many heart pieces you have
						Note: 4 heart pieces becomes a new heart csontainer
					
					RUPEES / WALLET / MONEY / R  :   shows you how many rupees you have
					
					INVENTORY / I  :   shows you your inventory
					
					EQUIPMENT / E  :   shows you your equipment
					
					CARRYING  :   tells you what you're carrying in front of you, if anything.

					NAVI / TALK TO NAVI  :   listens to navi if she calls to you, otherwise gives objective

					ENEMY INFO  :   gives you information about any enemies in the room

					STONES / SPIRITUAL STONES  :   shows you what spiritual stones you have

					MEDALLIONS  :   shows you what medallions you have

					TOKENS / GOLD SKULLTULA TOKENS  :   shows you how many gold skulltula tokens you have
					
					BRIEF  :   long room descriptions will not show for rooms you have already visited
					
					VERBOSE  :   restores long room descriptions
					
					HELP  :   gives you this help dialogue

					SAVE  :   saves your progress

					QUIT  :   quits the current game
						Alternative: SAVE AND QUIT


				ACTIONS:
					
					GO <direction>  :   moves you to a new room if able
						This action will only work for 'north', 'south', 'east', 'west', 'up', and 'down'.
						Abbreviations GO <'n'/'s'/'e'/'w'/'u'/'d'> are acceptable
						If a door is unlocked, it will open automatically if you go in its direction.

					TALK TO / SPEAK TO <person>  :   allows you to speak to a character in the room

					PICK UP / GET <item>  :   picks up an item in the room
						If the item can be added to your inventory, it will do so.
						Otherwise, you will carry the item in front of you.

					PUT DOWN / DROP <item> (optional: ON <item>)  :   puts down an item you are holding
						If the optional ON <item> is used, will drop the item on something in particular.

					THROW <item> (optional: AT <enemy/item>) :   roughly throws an item that you are holding in front of you
						If the item breaks, you will be given its contents, if it has any.

					OPEN <chest>  :   opens a chest, if able
						Note: do not use this action on doors. They will open automatically if you walk in their direction.

					STEP ON / PRESS <switch>  :   presses a floor switch temporarily

					BREAK <item> WITH <inventory item or sword>  :   breaks item and gives you its contents, if it has any

					BUY <item>  :   buys an item in a shop, if you have sufficient funds

					LIGHT <item> WITH <item>  :   lights an object on fire using another already lit object
						You can use this to light flammable items from your inventory on fire.
						This can be used to light objects in the room on fire using something on fire in your inventory.

					EXTINGUISH DEKU STICK / EXTINGUISH STICK :   puts out your lit deku stick, if you have one

					PUSH / SLIDE <item>  :   pushes around an object in the room

					DIVE FOR <item>  :   reaches for an item submerged underwater



				FIGHTING ACTIONS:

					HIT <enemy/object> WITH <item>  :   hits an enemy or object in the room with an item you possess
						If the enemy dies, you will automatically be given any items it drops.

					SHOOT <enemy/object> WITH <item> :   shoots an enemy or object in the room with a weapon you possess

					SHOOT <item> AT <enemy/object> :   shoots an enemy or object in the room with a weapon you possess

					CUT <item/enemy>  :   cuts target with sword

					BLOCK  :   blocks incoming attacks with your shield

					DODGE  :   dodges incoming attacks

				"
			]
			game_output[:outputLines].concat(dialogue)
		end

	end
end

#future actions
	# SHOW <item> TO <person>  :   allows you to show something you have to a character in the room

	# UNLOCK <door>  :   unlocks a door if you have the appropriate key

	# PLAY <instrument or mini-game>  :   allows you to play an instrument or play a mini-game if one is available
