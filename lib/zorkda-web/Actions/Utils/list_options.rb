module Zorkda
	module Actions
		module Utils

			#DONE
			def self.list_options(items)
				Zorkda::GameOutput.add_line("These are your options: ")
				(items.length - 1).times do |i|
					separator = items.length > 2 ? ", " : " "
					Zorkda::GameOutput.append_text("#{items[i].name}#{separator}")
				end
				Zorkda::GameOutput.append_text("or #{items.last.name}.")
			end

		end
	end
end
