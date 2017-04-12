module Zorkda
	module Actions

		def self.dodge(game_status)
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
				Zorkda::GameOutput.add_line("There is no impending attack to dodge.")
			else
				player.equipment.each do |piece|
					if piece.is_a?(Zorkda::Actors::IronBoots)
						if piece.equipped
							Zorkda::GameOutput.add_line("Your iron boots make you too heavy to dodge.")
							return
						else
							break
						end
					end
				end
				attacking_enemies.each {|enemy| enemy.dodge(game_status) }
			end
		end

	end
end