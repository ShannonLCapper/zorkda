def block(game_status)
	player = game_status.player
	enemies = game_status.curr_room.enemies
	move_counter = game_status.move_counter
	attacking_enemies = []
	enemies.each do |enemy|
		if enemy.attacking
			attacking_enemies << enemy
		end
	end
	if attacking_enemies.length == 0
		puts "There is no impending attack to block."
	else
		shield_equipped = false
		player.equipment.each do |piece|
			if piece.is_a?(Shield) && piece.equipped
				shield_equipped = true
				break
			end
		end
		if !shield_equipped
			puts "You don't have a shield equipped to block with."
		else
			attacking_enemies.each {|enemy| enemy.block(game_status) }
		end
	end
end