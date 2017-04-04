class Shopkeeper < Character

	attr_accessor :wares, :gender

	def initialize(race, description, wares)
		if description == nil
			super(
				"#{race} Shopkeeper",
				description = "A #{race} shopkeeper stands behind the counter, with wares stacked on the back shelves.",
				race,
				0,
				"shopkeeper",
				"shopkeepers"
			)
		else
			super("#{race} Shopkeeper", description, race, 0, "shopkeeper", "shopkeepers")
		end
		@wares = wares
	end

	def speak(game_status)
		puts self.name + ": "
		print "\""
		dialogue(game_status)
		puts "\""
	end

	def dialogue(game_status)
		if wares.length == 0
			print "Welcome to my shop! Unfortunately, I don't currently have anything for sale. Sorry!"
		else
			puts "Welcome to my shop! This is what I have for sale:"
			self.wares.each do |ware|
				print "\t#{ware.name}"
				if ware.inventory_quantity > 0
					if ware.price == 1
						puts ": #{ware.price} rupee"
					else
						puts ": #{ware.price} rupees"
					end
				else
					puts ": SOLD OUT"
				end
			end
			print "You can buy something by typing \"buy\" and the name of the item you want."
		end
	end

	def sold_out_dialogue(ware)
		puts "#{self.name}: \"Sorry kid, we're all sold out of #{ware.gen_plural}.\""
	end

	def item_not_found_dialogue
		puts "#{self.name}: \"Whatever that is, we don't have any for sale.\""
	end

	def cant_afford_dialogue
		puts "#{self.name}: \"It looks like that costs a little more than you can afford.\""
	end

	def take_ware(ware)
		ware.inventory_quantity -= 1
	end
end

class Kokiri_shopkeeper < Shopkeeper

	def initialize
		super("Kokiri", nil, [Arrows_ware.new(10, 20), Arrows_ware.new(30, 60), Deku_nuts_ware.new(5, 15), Deku_nuts_ware.new(10, 30), Deku_seeds_ware.new(30, 30), Deku_shield_ware.new(40), Deku_stick_ware.new(10), Heart_ware.new(10)])
	end
end

class Bazaar_shopkeeper < Shopkeeper

	def initialize
		super("Hylian", nil, [Arrows_ware.new(10, 20), Arrows_ware.new(30, 60), Arrows_ware.new(50, 90), Bombs_ware.new(5, 35), Deku_nuts_ware.new(5, 15), Deku_stick_ware.new(10), Hylian_shield_ware.new(80), Heart_ware.new(10)])
	end
end

class Goron_shopkeeper < Shopkeeper

	def initialize
		super("Goron", nil, [Bombs_ware.new(5, 25), Bombs_ware.new(10, 50), Bombs_ware.new(20, 80), Bombs_ware.new(30, 120), Goron_tunic_ware.new(200), Heart_ware.new(10)])
	end
end

class Zora_shopkeeper < Shopkeeper

	def initialize
		super("Zora", nil, [Arrows_ware.new(10, 20), Arrows_ware.new(30, 60), Arrows_ware.new(50, 90), Deku_nuts_ware.new(5, 15), Zora_tunic_ware.new(300)])
	end
end