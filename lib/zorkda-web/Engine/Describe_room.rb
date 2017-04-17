module Zorkda
	module Engine

		#DONE
		def self.describe_room(room)
			#give description of room itself
			if room.description
				Zorkda::GameOutput.add_line(room.description)
			end
			#describe directions you can go in room
			self.describe_directions_in_room(room)
			#describe items in room
			submerged = self.describe_array(room.inventory, "The area also contains these items")

			#describe characters in room
			submerged.concat(self.describe_array(room.characters, "The following people are present as well"))

			#describe enemies in room
			submerged.concat(self.describe_array(room.enemies, "In addition, these enemies lurk nearby"))

			if submerged.length > 0
				text_line = "Below the surface of the water, you can also see the following: "
				(submerged.length - 1).times do |i|
					text_line += submerged[i].name + ", "
				end
				text_line += submerged.last.name
				Zorkda::GameOutput.add_line(text_line)
			end
		end

	end
end