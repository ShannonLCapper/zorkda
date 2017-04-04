def equip(game_status, obj)
	player = game_status.player
	matches = find_matches(player.equipment, obj)
	if matches.length == 0
		puts "That's not something you have in your equipment."
	elsif matches.length > 1
		puts "You're going to have to be more specific about what you want to equip."
		list_options(matches)
		puts "Type \"equip\" and the item you want."
	else
		obj = matches[0]
		if obj.equipped
			puts "That item is already equipped."
		elsif !obj.available_as_adult && player.age == "adult"
			puts "You can only equip that as a child."
		elsif !obj.available_as_child && player.age == "child"
			puts "You can only equip that as an adult."
		else
			player.equipment.each do |piece|
				if piece.type == obj.type && piece.equipped
					player.deequip_piece(piece)
				end
			end
			player.equip_piece(obj)
			puts "You now have the #{obj.name} equipped!"
		end
	end
end