module Zorkda
	module Actions

		def self.equip(game_status, obj)
			player = game_status.player
			matches = self::Utils.find_matches(player.equipment, obj)
			if matches.length == 0
				Zorkda::GameOutput.add_line("That's not something you have in your equipment.")
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to equip.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Type &quot;equip&quot; and the item you want.")
			else
				obj = matches[0]
				if obj.equipped
					Zorkda::GameOutput.add_line("That item is already equipped.")
				elsif !obj.available_as_adult && player.age == "adult"
					Zorkda::GameOutput.add_line("You can only equip that as a child.")
				elsif !obj.available_as_child && player.age == "child"
					Zorkda::GameOutput.add_line("You can only equip that as an adult.")
				else
					player.equipment.each do |piece|
						if piece.type == obj.type && piece.equipped
							player.deequip_piece(piece)
						end
					end
					player.equip_piece(obj)
					Zorkda::GameOutput.add_line("You now have the #{obj.name} equipped!")
				end
			end
		end

	end
end