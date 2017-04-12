module Zorkda
	module Parser
		module Utils

			#DONE
			def self.action_one_obj_dont_allow_certain_words(action_keywords, action_method, not_allowed_words, game_status, response)
				full_match, partial_match = self.does_response_match_action(action_keywords, response)
				if full_match
					action_keywords.split(" ").length.times { response.delete_at(0) }
					not_allowed_words.each do |word|
						if response.include?(word)
							Zorkda::GameOutput.add_line("Just type &quot;#{action_keywords}&quot; and the item you want.")
							return true
						end
					end
					obj = self.get_obj_no_keyword(response)
					if obj == ""
						Zorkda::GameOutput.add_line("You need to say what you want to #{action_keywords}.")
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

		end
	end
end