def run_game(game_status)
	enter_room(game_status)
	game_status.player.update_player(game_status)
	game_status.curr_room.update_room_conditions(game_status)
	game_status.curr_room.enemies.each {|enemy| enemy.update(game_status)}
	game_status.curr_room.number_generic_names_when_others_present(game_status.curr_room.enemies)
	game_status.player.check_if_on_fire
	while true
		if game_status.player.can_move
			parser(game_status)
		else
			prompt
			puts "You still can't move."
		end
		game_status.move_counter += 1
		game_status.player.update_player(game_status)
		game_status.curr_room.update_room_conditions(game_status)
		game_status.curr_room.enemies.each {|enemy| enemy.update(game_status)}
		game_status.curr_room.number_generic_names_when_others_present(game_status.curr_room.enemies)
		game_status.player.check_if_on_fire
	end
end