module Zorkda
	module Actions

		def self.roll_into(game_status, obj)
			curr_room = game_status.curr_room
			player = game_status.player
			move_counter = game_status.move_counter
			#find matches
			matches = self::Utils.find_matches_search_all(curr_room, obj)
			#if there are no matches
			if matches.length == 0
				Zorkda::GameOutput.add_line("Your target is either not here or not something with which you can interact.")
				return
			#if more than one thing matches, ask to be more specific
			elsif matches.length > 1
				Zorkda::GameOutput.add_line("You're going to have to be more specific.")
				self::Utils.list_options(matches)
				Zorkda::GameOutput.add_line("Type &quot;roll into&quot; and the item you want.")
				return
			else
				obj = matches[0]
				if obj.distance > 0
					Zorkda::GameOutput.add_line("That's too far away.")
				elsif (obj.submerged || curr_room.underwater) && player.weight < 2
					Zorkda::GameOutput.add_line("That's underwater, and you can't roll into it while you're floating around.")
				elsif obj.is_a?(Zorkda::Actors::Character)
					Zorkda::GameOutput.add_line("It's rather rude to roll into people.")
				elsif obj.is_a?(Zorkda::Actors::Enemy)
						Zorkda::GameOutput.add_line("Well that wasn't very smart.")
						obj.touch(game_status)
				elsif !obj.can_roll_into
					Zorkda::GameOutput.add_line("You roll, but not much happens.")
				elsif obj.is_a?(Zorkda::Actors::Tree)
					if obj.contents != nil && obj.contents.length > 0
						Zorkda::GameOutput.add_line("You roll into the #{obj.name}, and it drops the following to the ground: ")
						(obj.contents.length - 1).times do |i|
							separator = obj.contents.length > 2 ? ", " : " "
							Zorkda::GameOutput.append_text(obj.contents[i].name + separator)
						end
						separator = obj.contents.length > 1 ? "and " : ""
						Zorkda::GameOutput.append_text("#{separator}#{obj.contents.last.name}")
						obj.contents.each do |item|
							if item.is_a?(Zorkda::Actors::Enemy)
								curr_room.enemies << item
							elsif item.is_a?(Zorkda::Actors::Character)
								curr_room.characters << item
							else
								curr_room.inventory << item
							end
						end
						obj.contents = []
					else
						Zorkda::GameOutput.add_line("You roll into the #{obj.name}, but it just drops a few leaves.")
					end
				elsif obj.breakable
					obj.break(player)
				else
					Zorkda::GameOutput.add_line("You pick up the #{obj.name}.")
					obj.pick_up(game_status)
				end
			end
		end

	end
end