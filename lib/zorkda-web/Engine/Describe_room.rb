def describe_room(room)
	#give description of room itself
	if room.description != nil
		puts room.description
	end
	#describe directions you can go in room
	describe_directions_in_room(room)
	#describe items in room
	submerged = describe_array(room.inventory, "The room also contains these items")

	#describe characters in room
	submerged = submerged.concat(describe_array(room.characters, "The following people are present as well"))

	#describe enemies in room
	submerged = submerged.concat(describe_array(room.enemies, "In addition, these enemies lurk nearby"))

	if submerged.length > 0
		print "Below the surface of the water, you can also see the following: "
		(submerged.length - 1).times do |i|
			print submerged[i].name + ", "
		end
		puts submerged.last.name
	end
end

def describe_array(array, banner_for_items_without_desc)
	submerged = []
	if array != [] && array != nil
		non_descriptions = []
		array.each do |entry|
			if !entry.display
				next
			elsif entry.description != nil
				if /[A-Z0-9]/.match(entry.description[0]) == nil
					print entry.description[0].upcase + entry.description[1..-1]
				else
					print entry.description
				end
				if /\./.match(entry.description[-1]) == nil
					puts "."
				else
					puts "\n"
				end
			elsif entry.submerged
				submerged << entry
			else
				non_descriptions << entry
			end
		end
		if non_descriptions.length > 0
			print banner_for_items_without_desc + ": "
			(non_descriptions.length - 1).times do |i|
				print non_descriptions[i].name 
				if non_descriptions[i].has_parenthetical_name
					print " (" + non_descriptions[i].parenthetical_name + ")"
				end
				print ", "
			end
			print non_descriptions.last.name
			if non_descriptions.last.has_parenthetical_name
				puts " (" + non_descriptions.last.parenthetical_name + ")"
			else
				puts "\n"
			end
		end
	end
	return submerged
end