def list_options(items)
	print "These are your options: "
	(items.length - 1).times do |i|
		print "#{items[i].name}"
		if items.length > 2
			print ", "
		else
			print " "
		end
	end
	puts "or #{items.last.name}."
end