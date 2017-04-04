def describe_directions_in_room(room)	
	sides = []
	sides << room.nside << room.sside << room.wside << room.eside << room.uside << room.dside
	similar_side_groups = [[], [], []]
	remaining_sides = []
	sides[0..3].each do |side|
		matched = false
		side_has_plural = defined?(side.plural_description) && !side.plural_description.nil?
		if side_has_plural && side.display
			similar_side_groups.each do |similar_sides|
				if similar_sides.empty? 
					similar_sides << side
					matched = true
					break
				elsif side.plural_description == similar_sides.first.plural_description
					similar_sides << side
					matched = true
					break
				end
			end
		end
		remaining_sides << side unless matched
	end
	remaining_sides << sides[4] << sides[5]
	similar_side_groups.each do |similar_sides|
		if similar_sides.length == 1
			remaining_sides << similar_sides.first
			next
		elsif !similar_sides.empty?
			directions = []
			similar_sides.each { |side| directions << side.direction }
			print "To the #{directions.first}"
			if directions.length > 2
				print ","
				directions[1...-1].each { |direction| print " #{direction}," }
			end
			puts " and #{directions.last}, #{similar_sides.first.plural_description}."
		end
	end
	remaining_sides.each { |side| side.give_description if side.display }
end