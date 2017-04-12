module Zorkda
	module Parser
		module Utils

			#DONE
			def self.action_two_objs_opposite_splitter_words(action_keywords, splitter_words, action_method, game_status, response)
				full_match, partial_match = self.does_response_match_action(action_keywords, response)
				if full_match
					action_keywords.split(" ").length.times { response.delete_at(0) }
					if response.length == 0
						Zorkda::GameOutput.add_line("You need to say what you want to #{action_keywords}.")
						return true
					elsif response.include?(splitter_words[0])
						target = self.get_obj_before_keyword(response, splitter_words[0])
						with_obj = self.get_obj_after_keyword(response, splitter_words[0])
					elsif response.include?(splitter_words[1])
						target = self.get_obj_after_keyword(response, splitter_words[1])
						with_obj = self.get_obj_before_keyword(response, splitter_words[1])
					else
						Zorkda::GameOutput.add_line("You must say both what you want to #{action_keywords} and what you want to #{action_keywords} it #{splitter_words[0]}.")
						return true
					end
					if target == ""
						Zorkda::GameOutput.add_line("You need to say what your target is.")
					elsif with_obj == ""
						Zorkda::GameOutput.add_line("You need to say what you want to #{action_keywords} that #{splitter_words[0]}.")
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

		end
	end
end