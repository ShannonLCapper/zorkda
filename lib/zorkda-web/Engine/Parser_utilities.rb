def prompt
	print "> "
	return $stdin.gets.chomp
end


#checks for recognized actions
def action_no_obj(action_keywords, action_method, game_status, response)
	full_match, partial_match = does_response_match_action(action_keywords, response)
	if full_match
		if response.length > 1
			puts "Just type \"#{action_keywords}\"."
		else
			action_method.call(game_status)
		end
		return true
	elsif partial_match
		return true
	else
		return false
	end
end

def action_one_obj_dont_allow_certain_words(action_keywords, action_method, not_allowed_words, game_status, response)
	full_match, partial_match = does_response_match_action(action_keywords, response)
	if full_match
		action_keywords.split(" ").length.times { response.delete_at(0) }
		not_allowed_words.each do |word|
			if response.include?(word)
				puts "Just type \"#{action_keywords}\" and the item you want."
				return true
			end
		end
		obj = get_obj_no_keyword(response)
		if obj == ""
			puts "You need to say what you want to #{action_keywords}."
		else
			action_method.call(game_status, obj)
		end	
		return true
	elsif partial_match
		return true
	else
		return false
	end
end

def action_one_obj(action_keywords, action_method, game_status, response)
	full_match, partial_match = does_response_match_action(action_keywords, response)
	if full_match
		action_keywords.split(" ").length.times { response.delete_at(0) }
		obj = get_obj_no_keyword(response)
		if obj == ""
			puts "You need to say what you want to #{action_keywords}."
		else
			action_method.call(game_status, obj)
		end
		return true
	elsif partial_match
		return true
	else
		return false
	end
end

def action_one_or_two_objs(action_keywords, splitter_word, action_method, game_status, response)
	full_match, partial_match = does_response_match_action(action_keywords, response)
	if full_match
		action_keywords.split(" ").length.times { response.delete_at(0) }
		if response.include?(splitter_word)
			first_obj = get_obj_before_keyword(response, splitter_word)
			second_obj = get_obj_after_keyword(response, splitter_word)
		else
			first_obj = get_obj_no_keyword(response)
			second_obj = nil
		end
		if first_obj == ""
			puts "You need to say what you want to #{action_keywords}."
		elsif second_obj == ""
			puts "You need to say what you want to #{action_keywords} that #{splitter_word}."
		else
			action_method.call(game_status, first_obj, second_obj)
		end
		return true
	elsif partial_match
		return true
	else
		return false
	end
end

def action_two_objs(action_keywords, splitter_word, action_method, game_status, response)
	full_match, partial_match = does_response_match_action(action_keywords, response)
	if full_match
		action_keywords.split(" ").length.times { response.delete_at(0) }
		if response.length == 0
			puts "You need to say what you want to #{action_keywords}."
			return true
		elsif response.include?(splitter_word)
			first_obj = get_obj_before_keyword(response, splitter_word)
			second_obj = get_obj_after_keyword(response, splitter_word)
		else
			puts "You need to say what you want to #{action_keywords} that #{splitter_word}."
			return true
		end
		if first_obj == ""
			puts "You need to say what you want to #{action_keywords}."
		elsif second_obj == ""
			puts "You need to say what you want to #{action_keywords} that #{splitter_word}."
		else
			action_method.call(game_status, first_obj, second_obj)
		end
		return true
	elsif partial_match
		return true
	else
		return false
	end
end

def action_two_objs_opposite_splitter_words(action_keywords, splitter_words, action_method, game_status, response)
	full_match, partial_match = does_response_match_action(action_keywords, response)
	if full_match
		action_keywords.split(" ").length.times { response.delete_at(0) }
		if response.length == 0
			puts "You need to say what you want to #{action_keywords}."
			return true
		elsif response.include?(splitter_words[0])
			target = get_obj_before_keyword(response, splitter_words[0])
			with_obj = get_obj_after_keyword(response, splitter_words[0])
		elsif response.include?(splitter_words[1])
			target = get_obj_after_keyword(response, splitter_words[1])
			with_obj = get_obj_before_keyword(response, splitter_words[1])
		else
			puts "You must say both what you want to #{action_keywords} and what you want to #{action_keywords} it #{splitter_words[0]}."
			return true
		end
		if target == ""
			puts "You need to say what your target is."
		elsif with_obj == ""
			puts "You need to say what you want to #{action_keywords} that #{splitter_words[0]}."
		else
			action_method.call(game_status, target, with_obj)
		end
		return true
	elsif partial_match
		return true
	else
		return false
	end
end


def does_response_match_action(action_keywords, response) #returns if theres a full match first, partial match second
	action_keywords_array = action_keywords.split(" ")
	if action_keywords_array.length > 1
		action_keywords_array.length.times do |i|
			if response[i] != action_keywords_array[i]
				if i > 0
					puts "The action you're looking for is \"#{action_keywords_array.join(" ")}\"."
					return false, true
				else
					return false, false
				end
			end
		end
	elsif action_keywords != response[0]
		return false, false
	else
		return true, true
	end
end



#pull objects out of responses broken into an array of words
def get_obj_no_keyword(response_arr)
	if response_arr[0] == "the" || response_arr[0] == "that" || response_arr[0] == "those" || response_arr == "a" || response_arr == "my"
		response_arr.delete_at(0)
	end
	if response_arr.length == 0
		return ""
	end
	response_s = ""
	(response_arr.length - 1).times do |i|
		response_s << response_arr[i] << " "
	end
	response_s << response_arr.last
	return response_s
end

def get_obj_before_keyword(response, keyword)
	response_arr = response[0...(response.index(keyword))]
	if response_arr[0] == "the" || response_arr[0] == "that" || response_arr[0] == "those" || response_arr == "a" || response_arr == "my"
		response_arr.delete_at(0)
	end
	if response_arr.length == 0
		return ""
	end
	response_s = ""
	(response_arr.length - 1).times do |i|
		response_s << response_arr[i] << " "
	end
	response_s << response_arr.last
	return response_s
end

def get_obj_after_keyword(response, keyword)
	response_arr = response[(response.index(keyword) + 1)..-1]
	if response_arr[0] == "the" || response_arr[0] == "that" || response_arr[0] == "those" || response_arr == "a" || response_arr == "my"
		response_arr.delete_at(0)
	end
	if response_arr.length == 0
		return ""
	end
	response_s = ""
	(response_arr.length - 1).times do |i|
		response_s << response_arr[i] << " "
	end
	response_s << response_arr.last
	return response_s
end

def get_valid_yes_or_no
	valid_response = false
	until valid_response == true
		response = prompt.downcase
		if response == "yes" || response == "y"
			valid_response = true
			return "yes"
		elsif response == "no" || response == "n"
			valid_response = true
			return "no"
		else
			puts "I need a \"yes\" or \"no\"."
		end
	end
end