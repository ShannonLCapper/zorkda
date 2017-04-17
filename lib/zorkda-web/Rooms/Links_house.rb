module Zorkda
	module Rooms

		#DONE
		class Links_house < Room

			def initialize
				super()
				@name = "Link's Room"
				@description = "You are in a small, cozy, one-room treehouse."
				@location = nil
				@nside = Door.new("north")
				@sside.change_type(:wooden_wall)
				@eside.change_type(:wooden_wall)
				@wside.change_type(:wooden_wall)
				@uside.change_type(:ceiling)
				@has_entry_cutscene = true
			end

			def entry_cutscene(game_status)
				dialogue = [
					"Navi the Fairy: &quot;Hello #{game_status.player.name}!",
					"I'm going to be your partner from now on. Nice to meet you!",
					"The Great Deku Tree has summoned you! Let&#39;s get going!",
					"You can move around by typing &quot;go &lt;direction&gt;&quot;.",
					"To talk to me, type &quot;talk to Navi&quot; or just &quot;Navi&quot;."
				]
				Zorkda::GameOutput.add_lines(dialogue)

			end

		end

	end
end