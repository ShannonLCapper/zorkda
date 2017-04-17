module Zorkda
  module Actors
    
    #DONE
    class Mido < Character

			attr_accessor :moved

			def initialize
				super("Mido", "A pompous Kokiri boy, Mido, blocks the way east.", "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@moved = false
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				player = game_status.player
				curr_room = game_status.curr_room
				checkpoint = game_status.checkpoint
				if checkpoint < 2
					proper_equipment = 0
					player.equipment.each do |piece|
						if piece.equipped && (piece.is_a?(Zorkda::Actors::DekuShield) || piece.is_a?(Zorkda::Actors::KokiriSword))
							proper_equipment += 1
						end
					end
					if self.moved
						return [
							"I, the great Mido, will never accept you as one of us! " +
							"Shoot. How did you get to be the favorite of Saria and the Great Deku Tree? " +
							"Huh?! Grumble... grumble..."
						]
					elsif proper_equipment >= 2
						self.moved = true
						self.description = "The pompous Kokiri, Mido, stands off to one side."
						return [
							"If you want to see the Great Deku Tree, you should at least equip a sword and shield!",
							" ",
							"Eh, what's that?! Oh, you have a Deku Shield...",
							" ",
							"And what's THAT?! Is that the Kokiri Sword?!",
							"GOOD GRIEF!!",
							" ",
							"Well, even with all that stuff, a wimp is still a wimp, huh?",
							"I, the great Mido, will never accept you as one of us! " +
							"Shoot. How did you get to be the favorite of Saria and the Great Deku Tree? " +
							"Huh?! Grumble... grumble..."
						]
					elsif self.talked_to_checkpoints.length == 0
						self.talked_to_checkpoints << checkpoint
						return [
							"Hey you! &quot;Mr. No Fairy!&quot; " +
							"What's your business with the Great Deku Tree? " +
							"Without a fairy, you're not keven a real man!",
							" ",
							"What?! You've got a fairy?!",
							"Say what? The Great Deku Tree actually summoned you?",
							"WHAAAAAAAAAT???",
							" ",
							"Why would he summon you and not the great Mido? " +
							"This isn't funny...",
							"I don't believe it! You aren't even fully equipped yet! " +
							"How do you think you're going to help the Great Deku Tree without " +
							"both a sword and shield ready?",
							" ",
							"What? You're right, I dont have my equipment ready, but... " +
							"If you want to pass through here, you should at least equip a sword and shield! " +
							"Sheesh!"
						]
					else
						return "If you want to pass through here, " +
						       "you should at least equip a sword and shield! Sheesh!"
					end
				else
					puts "I don't know what to say."
				end
			end
		end

	end
end
