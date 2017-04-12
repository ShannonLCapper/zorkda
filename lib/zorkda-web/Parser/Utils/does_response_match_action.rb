module Zorkda
	module Parser			
		module Utils

			def self.does_response_match_action(action_keywords, response) #returns if theres a full match first, partial match second
				action_keywords_array = action_keywords.split(" ")
				if action_keywords_array.length > 1
					action_keywords_array.length.times do |i|
						if response[i] != action_keywords_array[i]
							if i > 0
								Zorkda::GameOutput.add_line(
									"The action you're looking for is &quot;#{action_keywords_array.join(" ")}&quot;."
								)
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

		end
	end
end