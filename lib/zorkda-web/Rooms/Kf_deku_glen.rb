module Zorkda
  module Rooms

  	#DONE
    class Kf_deku_glen < Room

			def initialize
				super()
				@name = "Greak Deku Tree's Glen"
				@description = "You're in a large clearing dominated by the towering Great Deku Tree."
				@location = "Kokiri Forest"
				@nside.change_type(:trees)
				@sside.change_type(:trees)
				@eside = Path.new("east", "the maw of the Great Deku Tree gapes open like a doorway")
				@wside = Pathway.new("west")
				@has_entry_cutscene = true
				@checkpoint_cutscene_list = [2]
				@visited_before = false
			end

			def entry_cutscene(game_status)
				dialogue = [
					"You walk into a wide glen. Before you stands the massive Deku Tree.",
					" ",
					"Navi: &quot;Great Deku Tree... I'm back!&quot;",
					"Great Deku Tree: &quot;Oh... Navi... Thou hast returned...",
					" ",
					"#{game_status.player.name}, welcome.",
					"Listen carefully to what I, the Deku Tree, am about to tell thee...",
					" ",
					"Thy slumber these past moons must have been restless, and full of nightmares... " +
					"As the servants of evil gain strength, a vile climate pervades the land " +
					"and causes nightmares to those sensitive to it... " +
					"Verily, thou hast felt it...",
					" ",
					"#{game_status.player.name}... the time has come to test thy courage... " +
					"I have been cursed... " +
					"I need you to break the curse with your wisdom and courage.&quot;",
					" ",
					"The Deku Tree's mouth creaks down to the ground, making an opening.",
					" ",
					"Great Deku Tree: &quot;Enter, brave #{game_status.player.name}, and thou too, Navi... ",
					"Navi the fairy, thou must aid #{game_status.player.name}. " +
					"And #{game_status.player.name}, if you hear something from Navi, " +
					"listen well to her words of wisdom with the command &quot;Navi&quot;.&quot;"
				]
				Zorkda::GameOutput.add_lines(dialogue)
				game_status.checkpoint += 1
			end

			def checkpoint_cutscenes(game_status, cutscene_num)
				if cutscene_num == 2
					dialogue = [
						"You land with a glow of light into the Great Deku Tree's glen.",
						" ",
						"Great Deku Tree: &quot;Well done, #{game_status.player.name}. " +
						"Thou hast verily demonstrated thy courage... " +
						"I knew that thou wouldst be able to carry out my wishes... " +
						"Now, I have yet more to tell ye...",
						"Listen carefully... ",
						" ",
						"A wicked man of the desert cast this dreadful curse upon me... " +
						"This evil man ceaselessly uses his vile, sourcerous powers in his search " +
						"for the Sacred Realm that is connected to Hyrule... " +
						"For it is in that Sacred Realm that one will find the divine relic, " +
						"the Triforce, which contains the essence of the gods...",
						# ".",
						# ".",
						# ".",
						# ".",
						# "Before time began, before spirits and life existed... " +
						# "Three golden goddesses descended upon the chaos that was Hyrule... " +
						# "Din, the goddess of power... " +
						# "Nayru, the goddess of wisdom... " +
						# "Farore, the goddess of courage...",
						# " ",
						# "Din, with her strong flaming arms, cultivated the land and created the red earth.",
						# " ",
						# "Nayru poured her wisdom onto the earth and gave the spirit of law to the world.",
						# " ",
						# "Farore, with her rich soul, produced all life forms who would uphold the law.",
						# " ",
						# "The three great goddesses, their labors completed, departed for the heavens, " +
						# "and golden sacred triangles remained at the point where they left the world " +
						# "Since then, the sacred triangles have become the basis of our world's providence. " +
						# "And the resting place of the triangles has become the Sacred Realm.",
						# .
						# .
						# .
						# .
						" ",
						"Thou must never allow the desert man in black armor " + 
						"to lay his hands on the sacred Triforce. " +
						"Thou must never suffer that man, with his evil heart, " +
						"to enter the Sacred Realm of legend... " +
						"That evil man who cast the death curse upon me and sapped my power... ",
						" ",
						"Because of that curse, my end is nigh... " +
						"Though your valiant efforts to break the curse were successful, " +
						"I was doomed before you started... ",
						" ",
						"Yes, I will pass away soon... " +
						"But do not grieve for me... " +
						"I have been able to tell you of these important matters... " +
						"This is Hyrule's final hope.",
						" ",
						"#{game_status.player.name}, go now to Hyrule Castle. " +
						"There, thou will surely meet the Princess of Destiny... " +
						"Take this stone with you. " +
						"The stone that man wanted so much that he cast the curse on me...&quot;",
						" ",
						" ",
						"You got the Kokiri's Emerald! It's a beautiful green stone with a gold swirl surrounding it. " +
						"This is the Spiritual Stone of the Forest, now entrusted to you by the Great Deku Tree.",
						" ",
						" ",
						"Great Deku Tree: &quot;The future depends upon thee, #{game_status.player.name}... " +
						"Thou art courageous...",
						" ",
						"Navi the fairy, help #{game_status.player.name} to carry out my will... " +
						"I entreat ye... Navi...",
						"Goodbye...&quot;",
						" ",
						"The Great Deku Tree leeches of color, his bark turning deathly gray. " +
						"The leaves of his mighty canopy turn brown and fall from their branches. " +
						"The Great Deku Tree has died.",
						" ",
						"You stand there, at a loss. After a long pause, Navi speaks.",
						" ",
						"Navi: &quot;Let's go to Hyrule Castle, #{game_status.player.name}!! " +
						"Goodbye... " +
						"Great Deku Tree...&quot;"
					]
					Zorkda::GameOutput.add_lines(dialogue)
					game_status.player.add_to_protagonist(Kokiri_emerald.new)
					Zorkda::GameOutput.new_paragraph
					Zorkda::GameOutput.add_line("You have reached the end of this trial. There will hopefully be more coming soon. Thanks for playing!")
				else
					Zorkda::GameOutput.add_line("error")
				end
			end
		end

	end
end