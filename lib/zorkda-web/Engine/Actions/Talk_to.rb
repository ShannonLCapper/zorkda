def talk_to(game_status, obj)
	curr_room = game_status.curr_room
	checkpoint = game_status.checkpoint
	matches = find_matches_search_all(curr_room, obj)
	if matches.length == 0
		puts "Are you talking to yourself? There's no one here by that name."
	elsif matches[0].is_a?(Enemy)
		puts "Enemies aren't really big on intellectually stimulating conversations."
	elsif !matches[0].is_a?(Character)
		puts "Uh, you feeling ok? You can talk to an inanimate object, but it won't talk back."
	elsif matches.length > 1
		puts "You're going to have to be a little more specific about who you want to talk to."
		list_options(matches)
		puts "Type \"talk to\" and the name of the person you want."
	else
		person = matches[0]
		person.speak(game_status)
	end
end