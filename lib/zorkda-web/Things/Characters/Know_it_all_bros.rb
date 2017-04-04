class Know_it_all_bro_1 < Character

	def initialize
		super("Brother 1", nil, "Kokiri", 0, "Kokiri boy", "Kokiri boys")
		@parent_alias = true
		@parent_singular = "boy"
		@parent_plural = "boys"
	end

	def dialogue(game_status)
		return "I can teach you about actions.
When you get an inventory item, you can use it using action commands.
Which action commands are relevant to that item will be listed when you get your first one.

Actions can also be done to things in the room. 

Some actions have optional parts.
For example, you can \"throw pot\", or you can \"throw pot at boulder\".
Use the \"help\" command for a list of valid actions."
	end

end

class Know_it_all_bro_2 < Character

	def initialize
		super("Brother 2", nil, "Kokiri", 0, "Kokiri boy", "Kokiri boys")
		@parent_alias = true
		@parent_singular = "boy"
		@parent_plural = "boys"
	end

	def dialogue(game_status)
		return "I can teach you how to talk to your fairy.
If you hear a \"Hey!\", that means your fairy has something to say to you.
You can talk to her using \"talk to Navi\" or just \"Navi\".
If you talk to her when she hasn't called to you, she'll tell you your objective.
If you want to her to tell you about enemies in the room, type \"enemy info\"."
	end

end


class Know_it_all_bro_3 < Character

	def initialize
		super("Brother 3", nil, "Kokiri", 0, "Kokiri boy", "Kokiri boys")
		@parent_alias = true
		@parent_singular = "boy"
		@parent_plural = "boys"
	end

	def speak(game_status)
		print self.name + ": "
		print "\""
		stream_dialogue("Do you want to learn about your items? 
Be prepared for a long description if you do.")
		puts "\""
		response = get_valid_yes_or_no
		if response == "yes"
			print self.name + ": "
			print "\""
			dialogue1 = dialogue
			stream_dialogue(dialogue1)
			puts "\""
		else
			print self.name + ": "
			print "\""
			stream_dialogue("Alright then.")
			puts "\""
		end
	end

	def dialogue
		return "You have three kinds of items.

Equipment items are things like the sword, shield, and clothes that can only be used when equipped.
You can equip equipment items with the command \"equip <item>\"
You can see what equipment you have using the command \"equipment\" or \"e\".

Inventory items can be used anytime without equipping, 
but you can't be holding something while using them.
You can see what inventory items you have using the commmand \"inventory\" or \"i\".

Quest items are things you collect during your adventure. You can't actually use them.
They each have their own unique command to see them. Type \"help\" for the full list."
	end

end