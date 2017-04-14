module Zorkda
	module Engine

		def self.run_game(game_status, input = nil)
			Zorkda::GameOutput.reset
			if input
				if game_status.end_of_game
					Zorkda::GameOutput.add_line(
						"You have reached the end of this trial. There will hopefully be more coming soon. " +
						"Thanks for playing!"
					)
				elsif game_status.player.dead
					self.respawn_player(game_status)
				elsif game_status.player.can_move
					Zorkda::Parser.parse(game_status, input)
				else
					Zorkda::GameOutput.add_line("You still can't move.")
				end
				game_status.move_counter += 1
			else # this will only happen upon game session start
				if game_status.player.dead
					self.respawn_player(game_status)
				else
				self.enter_room(game_status)
				end
			end
			game_status.player.update_player(game_status)
			game_status.curr_room.update_room_conditions(game_status)
			game_status.curr_room.enemies.each {|enemy| enemy.update(game_status)}
			game_status.curr_room.number_generic_names_when_others_present(game_status.curr_room.enemies)
			game_status.player.check_if_on_fire
			Zorkda::GameOutput.set_location(game_status.get_location)
			# Zorkda::GameOutput.add_line("You are on move #{game_status.move_counter.to_i}") #temp
			# Zorkda::GameOutput.set_navi(true) #temp
			return Zorkda::GameOutput.get
		end

	end
end