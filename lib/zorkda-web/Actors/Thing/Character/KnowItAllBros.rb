module Zorkda
  module Actors
    
    #DONE
    class KnowItAllBro1 < Character

			def initialize
				super("Brother 1", nil, "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				return [
					"I can teach you about actions.",
					"When you get an inventory item, you can use it using action commands. " +
					"Which action commands are relevant to that item will be " +
					"listed when you get your first one.",
					" ",
					"Actions can also be done to things around you.", 
					" ",
					"Some actions have optional parts. " +
					"For example, you can &quot;throw pot&quot;, or you can &quot;throw pot at boulder&quot;. " +
					"Use the &quot;help&quot; command for a list of valid actions."
				]
			end

		end

		class KnowItAllBro2 < Character

			def initialize
				super("Brother 2", nil, "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				return [
					"I can teach you how to talk to your fairy.",
					"If you hear a &quot;Hey!&quot;, that means your fairy has something to say to you.",
					"You can talk to her using &quot;talk to Navi&quot; or just &quot;Navi&quot;.",
					"If you talk to her when she hasn't called to you, she'll tell you your objective.",
					"If you want her to tell you about enemies in the area, type &quot;enemy info&quot;."
				]
			end

		end


		class KnowItAllBro3 < Character

			def initialize
				super("Brother 3", nil, "Kokiri", 0, "Kokiri boy", "Kokiri boys")
				@parent_alias = true
				@parent_singular = "boy"
				@parent_plural = "boys"
			end

			def dialogue(game_status)
				return [
					"I can teach you about items. There are three kinds.",
					" ",
					"Equipment items are things like the sword, shield, and clothes that can only be used when equipped.",
					"You can equip equipment items with the command &quot;equip &lt;item&gt;&quot;",
					"You can see what equipment you have using the command &quot;equipment&quot; or &quot;e&quot;.",
					" ",
					"Inventory items can be used anytime without equipping, " +
					"but you can't be holding something while using them. " +
					"You can see what inventory items you have using the commmand &quot;inventory&quot; or &quot;i&quot;.",
					" ",
					"Quest items are things you collect during your adventure. You can't actually use them. " +
					"They each have their own unique command to see them. Check out the help screen to see the full list."
				]
			end

		end

	end
end