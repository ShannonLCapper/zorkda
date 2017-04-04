def save(game_status)
	file = open(File.expand_path("../../Game_files/#{game_status.file_name}.txt", __FILE__), "wb+")
	game_data = Marshal.dump(game_status)
	file.write(game_data)
	file.close
	puts "Game saved!"
end