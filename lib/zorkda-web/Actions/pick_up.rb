module Zorkda
	module Actions

		def self.pick_up(game_status, obj)
			curr_room = game_status.curr_room
			player = game_status.player
			move_counter = game_status.move_counter
			matches, matched_parent, parent_singular, parent_plural = self::Utils.find_matches_search_all_id_parent(curr_room, obj)
			#if more than one item matched, check to make sure valid
			if matches.length > 1 
				#if there are carryable items the user could be referring to
				if matches[0].is_a?(Zorkda::Actors::TerrainItem) || matches[0].is_a?(Zorkda::Actors::Character) || matches[0].is_a?(Zorkda::Actors::Enemy)
					Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to pick up.")
					self::Utils.list_options(matches)
					Zorkda::GameOutput.add_line("Type &quot;pick up&quot; and the thing you want.")
					return
				#if only the general plural matched, and the user asked in the general singular
				elsif !matched_parent && matches[0].gen_singular.downcase == obj && 
				matches[0].gen_singular.downcase != matches[0].gen_plural.downcase
					Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to pick up.")
					self::Utils.list_options(matches)
					Zorkda::GameOutput.add_line("Type &quot;pick up&quot; and the item you want, or just &quot;pick up #{matches[0].gen_plural}&quot;.")
					return
				elsif matched_parent && obj == parent_singular && 
				parent_plural != parent_singular
					Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to pick up.")
					self::Utils.list_options(matches)
					Zorkda::GameOutput.add_line("Type &quot;pick up&quot; and the item you want, or just &quot;pick up #{parent_plural}&quot;.")
					return
				end
			end
			#there is no item in the room matching the obj
			if matches.length == 0
				Zorkda::GameOutput.add_line("That's either not here or not something with which you can interact.")
				Zorkda::GameOutput.add_line("Make sure you're just typing &quot;pick up &lt;thing&gt;&quot;.")
			#you're trying to pick up an enemy
			elsif matches[0].is_a?(Zorkda::Actors::Enemy)
				if matches.length > 1
					Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to pick up.")
					self::Utils.list_options(matches)
					Zorkda::GameOutput.add_line("Type &quot;pick up&quot; and the item you want.")
				elsif matches[0].distance > 0
					Zorkda::GameOutput.add_line("That enemy is too far away to reach.")
				else
					Zorkda::GameOutput.add_line("Well that was a stupid idea.")
					matches[0].touch(game_status)
				end
			#the item is a type that can't be picked up
			elsif !matches[0].can_pick_up
				Zorkda::GameOutput.add_line("That's not really something you can pick up.")
			#the item is something you carry and your hands are full
			elsif (matches[0].is_a?(Zorkda::Actors::TerrainItem) || matches[0].is_a?(Zorkda::Actors::Character) || matches[0].is_a?(Zorkda::Actors::Enemy)) && player.carrying != nil
				Zorkda::GameOutput.add_line("You're already carrying something. Drop that first.")
			else
				matches.each do |item|
					#the item is too far away
					if item.distance > 0
						Zorkda::GameOutput.add_line("#{item.name[0].upcase}#{item.name[1..-1]} out of reach.")
					#the item is underwater and link doesn't have iron boots on
					elsif (item.submerged || curr_room.underwater) && player.weight < 2
						Zorkda::GameOutput.add_line("The submerged #{item.name} can't be picked up while you're floating around.")
					#the item is too heavy
					elsif player.strength < item.weight
						Zorkda::GameOutput.add_line("You try to pick up the #{item.name}, but it's too heavy for you to lift. Sorry, Muscles.")
					#link can pick up the item
					else
						#if its a terrain item or character that can be picked up, carry
						if item.is_a?(Zorkda::Actors::TerrainItem) || item.is_a?(Zorkda::Actors::Character)
							if matches.length > 1
								Zorkda::GameOutput.add_line("You're going to have to be more specific about what you want to pick up.")
								self::Utils.list_options(matches)
								Zorkda::GameOutput.add_line("Type &quot;pick up&quot; and the item you want.")
							else
								item.pick_up(game_status)
								Zorkda::GameOutput.add_line("You're now carrying the following item in front of you: #{item.name}")
							end
						#other item, add to link
						else
							Zorkda::GameOutput.add_line("#{item.name[0].upcase}#{item.name[1..-1]} picked up.")
							item.pick_up(game_status)
						end
					end
				end
			end
		end

	end
end