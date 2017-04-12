module Zorkda
	module Engine

		#DONE
		def self.rng_contents(player)
			num_of_contents = [0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3].sample
			possibilities = [
				Zorkda::Actors::Heart.new(nil, nil, false), 
				Zorkda::Actors::GreenRupee.new(nil, nil, false), 
				Zorkda::Actors::BlueRupee.new(nil, nil, false),
				Zorkda::Actors::DekuNuts.new
			]
			 if player.has_bombs
			 	possibilities << Zorkda::Actors::Bombs.new
			 end
			 if player.has_slingshot && player.age == "child"
			 	possibilities << Zorkda::Actors::DekuSeeds.new
			 end
			 if player.has_bow && player.age == "adult"
			 	possibilities << Zorkda::Actors::Arrows.new
			 end
			weighted_possibilities = []
			possibilities.each do |item|
				item.spawn_frequency.times { weighted_possibilities << item }
			end
			contents = []
			num_of_contents.times { contents << weighted_possibilities.sample }
			return contents
		end

	end
end