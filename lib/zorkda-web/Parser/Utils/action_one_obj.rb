module Zorkda
	module Parser
		module Utils

			#DONE
			def self.action_one_obj(action_keywords, action_method, game_status, response)
				full_match, partial_match = self.does_response_match_action(action_keywords, response)
				if full_match
					action_keywords.split(" ").length.times { response.delete_at(0) }
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