module Zorkda
	module Rooms

    #DONE
		class Path < Side

			attr_accessor :goes_to, :description, :plural_description

			def initialize(direction, description)
				super(direction)
				@description = description
				@plural_description = description
				@permeable = true
				@goes_to = nil
			end

			def give_description
				if self.direction == "up"
					text_line = "Going upward, "
				elsif self.direction == "down"
					text_line = "Below you, "
				else
					text_line = "To the #{self.direction}, "
				end
				text_line += "#{self.description}."
				Zorkda::GameOutput.add_line(text_line)
			end
		end

	end
end