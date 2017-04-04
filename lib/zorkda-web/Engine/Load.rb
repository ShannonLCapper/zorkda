def load_game(file_name)
	file = open(File.expand_path("../../Game_files/#{file_name}.txt", __FILE__), "rb")
	file_data = file.read
	file.close
	game_status = Marshal.load(file_data)
	game_status.file_name = file_name
	run_game(game_status)
end