module Zorkda
	module Parser
		module Utils

			#DONE
			def self.action_no_obj(action_keywords, action_method, game_status, response)
				full_match, partial_match = self.does_response_match_action(action_keywords, response)
				if full_match
					if response.length > 1
						Zorkda::GameOutput.add_line("Just type &quot;#{action_keywords}&quot;.")
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

		end
	end
end