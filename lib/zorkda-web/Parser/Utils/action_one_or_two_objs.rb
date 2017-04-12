module Zorkda
	module Parser
		module Utils

			#DONE
			def self.action_one_or_two_objs(action_keywords, splitter_word, action_method, game_status, response)
				full_match, partial_match = self.does_response_match_action(action_keywords, response)
				if full_match
					action_keywords.split(" ").length.times { response.delete_at(0) }
					if response.include?(splitter_word)
						first_obj = self.get_obj_before_keyword(response, splitter_word)
						second_obj = self.get_obj_after_keyword(response, splitter_word)
					else
						first_obj = self.get_obj_no_keyword(response)
						second_obj = nil
					end
					if first_obj == ""
						Zorkda::GameOutput.add_line("You need to say what you want to #{action_keywords}.")
					elsif second_obj == ""
						Zorkda::GameOutput.add_line("You need to say what you want to #{action_keywords} that #{splitter_word}.")
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

		end
	end
end