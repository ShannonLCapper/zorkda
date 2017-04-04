def enter_room(game_status)

	move_counter = game_status.move_counter
	curr_room = game_status.curr_room
	player = game_status.player
	brief = game_status.brief
	checkpoint = game_status.checkpoint

	#give cutscene if needed
	if !curr_room.visited_before && curr_room.has_entry_cutscene
		puts "\n"
		curr_room.entry_cutscene(game_status)
		puts "\n"
	elsif curr_room.checkpoint_cutscene_list.length > 0 && curr_room.checkpoint_cutscene_list[0] <= checkpoint
		puts "\n"
		curr_room.checkpoint_cutscenes(game_status, curr_room.checkpoint_cutscene_list[0])
		puts "\n"
		curr_room.checkpoint_cutscene_list.delete_at(0)
	end

	#respawn things in room
	respawn_room(curr_room, player)

	#update items that may have changed while you were gone
	items_to_delete = []
	curr_room.inventory.each do |item|
		if item.is_a?(Terrain_item) && item.random_contents
			item.contents = rng_contents(player)
		end
		if (item.is_a?(Lit_bomb) || item.is_a?(Bomb_flower)) && item.fuse_lit
			if move_counter > item.moves_when_activated + item.moves_to_explode
				items_to_delete << item
			end
		elsif item.is_a?(Temporary_torch)
			suppress_output{ item.update_if_should_go_out(move_counter) }
		elsif item.is_a?(Switch)
			suppress_output{ item.check_deactivation(move_counter) }
		end
	end
	items_to_delete.each do |item|
		curr_room.inventory.delete(item)
	end
	suppress_output{ curr_room.update_distances(game_status) }

	#update stop previous enemy attacks
	curr_room.enemies.each do |enemy|
		if enemy.attacking
			enemy.terminate_attack
		end
	end

	#print room location and name
	puts "\n"
	if curr_room.location != nil
		print "#{curr_room.location.upcase}"
		if curr_room.floor != nil
			print " (#{curr_room.floor.upcase}): "
		else
			print ": "
		end
	end
	puts curr_room.name.upcase
	if !curr_room.visited_before || !brief
		describe_room(curr_room)
	end

	#indicate navi hint
	if curr_room.navi_hint
		if $win_pkg_avail
			navi_sound = File.expand_path('../Navi_hey.wav', __FILE__)
			Sound.play(navi_sound, Sound::ASYNC)
		else
			print "\a"
		end
	end

	curr_room.visited_before = true
end

def respawn_room(curr_room, player)
	curr_room.respawn_while_in_room.each do |thing|
		if player.carrying != thing
			curr_room.respawn << thing
			curr_room.respawn_while_in_room.delete(thing)
		end
	end
	if curr_room.respawn.length != 0
		curr_room.respawn.each do |thing|
			if thing.random_contents
				thing.contents = rng_contents(player)
			end
			if thing.kind_of?(Enemy)
				curr_room.enemies << thing
			elsif thing.kind_of?(Character)
				curr_room.characters << thing
			else
				curr_room.inventory << thing
			end
		end
	end
	curr_room.respawn = []
	curr_room.update_names
end