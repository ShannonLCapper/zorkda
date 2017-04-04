class Gold_skulltula < Enemy

	def initialize(name, description, distance)
		super(name, "Gold Skulltula", "Gold Skulltulas", 2, [Gold_skulltula_token.new], distance)
		@description = description
		@navi_description = "This shiny gold arachnid is also known as a Spider of the Curse.
If you defeat it, you'll get a token as proof!"
		@respawn = false
		@attack_damage = 0
		@contact_damage = 1
		@speed = 0
		@aggression = 0
		@parent_alias = true
		@parent_singular = "spider"
		@parent_plural = "spiders"
	end
end