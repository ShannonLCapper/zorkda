module Zorkda
	module Engine

		#DONE
		def self.enter_room(game_status)

			move_counter = game_status.move_counter
			curr_room = game_status.curr_room
			player = game_status.player
			brief = game_status.brief
			checkpoint = game_status.checkpoint

			#give cutscene if needed
			if !curr_room.visited_before && curr_room.has_entry_cutscene
				Zorkda::GameOutput.new_paragraph
				curr_room.entry_cutscene(game_status)
				Zorkda::GameOutput.new_paragraph
			elsif curr_room.checkpoint_cutscene_list.length > 0 && curr_room.checkpoint_cutscene_list[0] <= checkpoint
				Zorkda::GameOutput.new_paragraph
				curr_room.checkpoint_cutscenes(game_status, curr_room.checkpoint_cutscene_list[0])
				Zorkda::GameOutput.new_paragraph
				curr_room.checkpoint_cutscene_list.delete_at(0)
			end

			#respawn things in room
			self.respawn_room(curr_room, player)

			#update items that may have changed while you were gone
			items_to_delete = []
			curr_room.inventory.each do |item|
				if item.is_a?(Zorkda::Actors::TerrainItem) && item.random_contents
					item.contents = self.rng_contents(player)
				end
				if (item.is_a?(Zorkda::Actors::LitBomb) || item.is_a?(Zorkda::Actors::BombFlower)) && item.fuse_lit
					if move_counter > item.moves_when_activated + item.moves_to_explode
						items_to_delete << item
					end
				elsif item.is_a?(Zorkda::Actors::TemporaryTorch)
					Zorkda::GameOutput.suppress_text_additions
					item.update_if_should_go_out(move_counter)
					Zorkda::GameOutput.unsuppress_text_additions
				elsif item.is_a?(Zorkda::Actors::Switch)
					Zorkda::GameOutput.suppress_text_additions
					item.check_deactivation(move_counter)
					Zorkda::GameOutput.unsuppress_text_additions
				end
			end
			items_to_delete.each do |item|
				curr_room.inventory.delete(item)
			end
			Zorkda::GameOutput.suppress_text_additions
			curr_room.update_distances(game_status)
			Zorkda::GameOutput.unsuppress_text_additions

			#update stop previous enemy attacks
			curr_room.enemies.each do |enemy|
				if enemy.attacking
					enemy.terminate_attack
				end
			end

			#output room location and name
			text_line = ""
			if curr_room.location
				text_line += curr_room.location.upcase
				text_line += curr_room.floor ? " (#{curr_room.floor.upcase}): " : ": "
			end
			text_line += curr_room.name.upcase
			Zorkda::GameOutput.add_line(text_line)
			if !curr_room.visited_before || !brief
				self.describe_room(curr_room)
			end

			#indicate navi hint
			if curr_room.navi_hint
				Zorkda::GameOutput.set_navi(true)
			end

			curr_room.visited_before = true
		end

	end
end