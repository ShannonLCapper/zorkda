def rng_contents(player)
	num_of_contents = [0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3].sample
	possibilities = [
		Heart.new(nil, nil, false), 
		Green_rupee.new(nil, nil, false), 
		Blue_rupee.new(nil, nil, false),
		Deku_nuts.new
	]
	 if player.has_bombs
	 	possibilities << Bombs.new
	 end
	 if player.has_slingshot && player.age == "child"
	 	possibilities << Deku_seeds.new
	 end
	 if player.has_bow && player.age == "adult"
	 	possibilities << Arrows.new
	 end
	weighted_possibilities = []
	possibilities.each do |item|
		item.spawn_frequency.times { weighted_possibilities << item }
	end
	contents = []
	num_of_contents.times { contents << weighted_possibilities.sample }
	return contents
end