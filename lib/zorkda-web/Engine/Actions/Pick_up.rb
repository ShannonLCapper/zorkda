def pick_up(game_status, obj)
	curr_room = game_status.curr_room
	player = game_status.player
	move_counter = game_status.move_counter
	matches, matched_parent, parent_singular, parent_plural = find_matches_search_all_id_parent(curr_room, obj)
	#if more than one item matched, check to make sure valid
	if matches.length > 1 
		#if there are carryable items the user could be referring to
		if matches[0].kind_of?(Terrain_item) || matches[0].kind_of?(Character) || matches[0].kind_of?(Enemy)
			puts "You're going to have to be more specific about what you want to pick up."
			list_options(matches)
			puts "Type \"pick up\" and the thing you want."
			return
		#if only the general plural matched, and the user asked in the general singular
		elsif !matched_parent && matches[0].gen_singular.downcase == obj && 
		matches[0].gen_singular.downcase != matches[0].gen_plural.downcase
			puts "You're going to have to be more specific about what you want to pick up."
			list_options(matches)
			puts "Type \"pick up\" and the item you want, or just \"pick up #{matches[0].gen_plural}\"."
			return
		elsif matched_parent && obj == parent_singular && 
		parent_plural != parent_singular
			puts "You're going to have to be more specific about what you want to pick up."
			list_options(matches)
			puts "Type \"pick up\" and the item you want, or just \"pick up #{parent_plural}\"."
			return
		end
	end
	#there is no item in the room matching the obj
	if matches.length == 0
		puts "That's either not here or not something with which you can interact."
		puts "Make sure you're just typing \"pick up <thing>\"."
	#you're trying to pick up an enemy
	elsif matches[0].is_a?(Enemy)
		if matches.length > 1
			puts "You're going to have to be more specific about what you want to pick up."
			list_options(matches)
			puts "Type \"pick up\" and the item you want."
		elsif matches[0].distance > 0
			puts "That enemy is too far away to reach."
		else
			puts "Well that was a stupid idea."
			matches[0].touch(game_status)
		end
	#the item is a type that can't be picked up
	elsif !matches[0].can_pick_up
		puts "That's not really something you can pick up."
	#the item is something you carry and your hands are full
	elsif (matches[0].kind_of?(Terrain_item) || matches[0].kind_of?(Character) || matches[0].kind_of?(Enemy)) && player.carrying != nil
		puts "You're already carrying something. Drop that first."
	else
		matches.each do |item|
			#the item is too far away
			if item.distance > 0
				puts "#{item.name[0].upcase}#{item.name[1..-1]} out of reach."
			#the item is underwater and link doesn't have iron boots on
			elsif (item.submerged || curr_room.underwater) && player.weight < 2
				puts "The submerged #{item.name} can't be picked up while you're floating around."
			#the item is too heavy
			elsif player.strength < item.weight
				puts "You try to pick up the #{item.name}, but it's too heavy for you to lift. Sorry, Muscles."
			#link can pick up the item
			else
				#if its a terrain item or character that can be picked up, carry
				if item.kind_of?(Terrain_item) || item.kind_of?(Character)
					if matches.length > 1
						puts "You're going to have to be more specific about what you want to pick up."
						list_options(matches)
						puts "Type \"pick up\" and the item you want."
					else
						item.pick_up(game_status)
						puts "You're now carrying the following item in front of you: #{item.name}"
					end
				#other item, add to link
				else
					puts "#{item.name[0].upcase}#{item.name[1..-1]} picked up."
					item.pick_up(game_status)
				end
			end
		end
	end
end