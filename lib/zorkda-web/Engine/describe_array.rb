module Zorkda
	module Engine

		#DONE
		def self.describe_array(array, banner_for_items_without_desc)
			submerged = []
			if array && !array.empty?
				non_descriptions = []
				array.each do |entry|
					next if !entry.display
					if entry.description

						if /[A-Z0-9]/.match(entry.description[0])
							text_line = entry.description
						else
							text_line = entry.description[0].upcase + entry.description[1..-1]
						end
						text_line += "." unless text_line[-1] == "."
						Zorkda::GameOutput.add_line(text_line)
					elsif entry.submerged
						submerged << entry
					else
						non_descriptions << entry
					end
				end
				if non_descriptions.length > 0
					text_line = banner_for_items_without_desc + ": "
					(non_descriptions.length).times do |i|
						text_line += non_descriptions[i].name 
						if non_descriptions[i].parenthetical_name
							text_line += " (#{non_descriptions[i].parenthetical_name})"
						end
						text_line += ", "
					end
					text_line = text_line[0...-2] # remove last set of ", "
					Zorkda::GameOutput.add_line(text_line)
				end
			end
			return submerged
		end

	end
end