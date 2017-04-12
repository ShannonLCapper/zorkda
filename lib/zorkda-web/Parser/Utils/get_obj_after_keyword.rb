module Zorkda
	module Parser
		module Utils

			#DONE
			#pull objects out of responses broken into an array of words
			def self.get_obj_after_keyword(response, keyword)
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

		end
	end
end