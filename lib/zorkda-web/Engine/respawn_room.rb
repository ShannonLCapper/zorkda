module Zorkda
	module Engine

		#DONE
		def self.respawn_room(curr_room, player)
			curr_room.respawn_while_in_room.each do |thing|
				if player.carrying != thing
					curr_room.respawn << thing
					curr_room.respawn_while_in_room.delete(thing)
				end
			end
			unless curr_room.respawn.length.zero?
				curr_room.respawn.each do |thing|
					if thing.random_contents
						thing.contents = rng_contents(player)
					end
					if thing.kind_of?(Zorkda::Actors::Enemy)
						curr_room.enemies << thing
					elsif thing.kind_of?(Zorkda::Actors::Character)
						curr_room.characters << thing
					else
						curr_room.inventory << thing
					end
				end
			end
			curr_room.respawn = []
			curr_room.update_names
		end

	end
end