class Gold_skulltula_token < Thing

	def initialize
		@name = "gold skulltula token"
	end
end

class Spiritual_stone < Thing

	def initialize(name, description)
		@name = name
		@description = description
	end
end

class Kokiri_emerald < Spiritual_stone

	def initialize
		super(
			"Kokiri's Emerald", 
			"You got the Kokiri's Emerald, a beautiful green stone with a gold swirl surrounding it. 
This is the Spiritual Stone of the Forest, now entrusted to you by the Great Deku Tree."
		)
	end
end

class Goron_ruby < Spiritual_stone
	
	def initialize
		super(
			"Goron's Ruby",
			"You obtained the Goron's Ruby, a sparkling red stone set into a V-shaped gold bracing.
This is the Spiritual Stone of Fire passed down by the Gorons."
		)
	end
end

class Zora_sapphire < Spiritual_stone

	def initialize
		super(
			"Zora's Sapphire",
			"You obtained the Zora's Sapphire, a trio of glimmering blue stones set among gold spikes.
This is the Spiritual Stone of Water passed down by the Zoras."
		)
	end
end

class Medallion < Thing

	def initialize(name, description)
		@name = name
		@description = description
	end
end

class Light_medallion < Medallion

	def initialize
		super(
			"Light Medallion",
			"You received the Light Medallion!
Rauru the Sage adds his power to yours!"
		)
	end
end

class Forest_medallion < Medallion

	def initialize
		super(
			"Forest Medallion",
			"You received the Forest Medallion!
Saria awakens as a Sage and adds her power to yours!"
		)
	end
end

class Fire_medallion < Medallion

	def initialize
		super(
			"Fire Medallion",
			"You received the Fire Medallion!
Darunia awakens as a Sage and adds his power to yours!"
		)
	end
end

class Water_medallion < Medallion

	def initialize
		super(
			"Water Medallion",
			"You received the Water Medallion!
Ruto awakens as a Sage and adds her power to yours!"
		)
	end
end

class Shadow_medallion < Medallion

	def initialize
		super(
			"Shadow Medallion",
			"You received the Shadow Medallion!
Impa awakens as a Sage and adds her power to yours!"
		)
	end
end

class Spirit_medallion < Medallion

	def initialize
		super(
			"Spirit Medallion",
			"You received the Spriti Medallion!
Nabooru awakens as a Sage and adds her power to yours!"
		)
	end
end