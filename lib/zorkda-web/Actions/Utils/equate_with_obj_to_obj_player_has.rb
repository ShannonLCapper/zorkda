module Zorkda
	module Actions
		module Utils

			#DONE
			def self.equate_with_obj_to_obj_player_has(player, with_obj, action) #returns nil if no appropriate item found, returns object if item found
				if with_obj == "hands" || with_obj == "hand" || with_obj == "fists" || with_obj == "fist"
					Zorkda::GameOutput.add_line("You don't want to hurt your delicate hands, do you?")
					return nil
				end
				#check inventory and carrying first
				matches = find_matches(player.inventory, with_obj).concat(find_matches(player.carrying, with_obj))
				if matches.length > 1
					Zorkda::GameOutput.add_line("You need to be more specific about what you want to #{action} with.")
					list_options(matches)
					Zorkda::GameOutput.add_line("Retype the &quot;#{action}&quot; command with the tool you want.")
					return nil
				elsif matches.length == 1
					return matches[0]
				else
					#search equipment
					matches, matched_parent, parent_singular, parent_plural = find_matches_id_parent(player.equipment, with_obj)
					#no matches
					if matches.length == 0
						Zorkda::GameOutput.add_line("You can't #{action} something with an object you don't have.")
						return nil
					#more than one found, user typed a general equipment type
					elsif matched_parent && matches.length > 1
						#find the specific piece of equipment that is equipped
						piece_equipped = false
						matches.each do |piece|
							if piece.equipped
								return piece
								piece_equipped = true
							end
						end
						#you have multiple of the equipment type, but none are equipped. This option should generally not be reached
						if piece_equipped == false
							Zorkda::GameOutput.add_line("You don't have any of that equipment type equipped.")
							return nil
						end
					#this option should never be reached since no equipment items should have the same name
					elsif matches.length > 1
						Zorkda::GameOutput.add_line("You need to be more specific about what you want to #{action} with.")
						list_options(matches)
						Zorkda::GameOutput.add_line("Retype the &quot;#{action}&quot; command with the tool you want.")
						return nil
					#the user typed a specific piece of equipment, which is not equipped
					elsif !matches[0].equipped
						Zorkda::GameOutput.add_line("That item is not currently equipped. You can equip it with the &quot;equip &lt;item&gt;&quot; command.")
						return nil
					#the user typed a specific piece of equipment, which is equipped
					else
						return matches[0]
					end
				end
			end

		end
	end
end