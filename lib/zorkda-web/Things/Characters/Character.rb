class Character < Thing

	attr_accessor :name, :description, :race, :gen_singular, :gen_plural, :awake,
	:parent_alias, :parent_singular, :parent_plural, :race_singular,
	:race_plural, :talked_to_checkpoints

	def initialize(name, description, race, distance, gen_singular, gen_plural)
		super()
		@name = name
		@description = description
		@race = race
		@distance = distance
		@gen_singular = gen_singular
		@gen_plural = gen_plural
		@parent_alias = false
		@parent_singular = parent_singular
		@parent_plural = parent_plural
		@race_singular = race
		if @race == "Goron" || @race == "Hylian"
			@race_plural = @race_singular + "s"
		else
			@race_plural = @race_singular
		end
		@awake = true
		@weight = 1
		@talked_to_checkpoints = []
	end

	def speak(game_status)
		if !self.awake
			puts "It looks like that person is asleep..."
		else
			print self.name + ": "
			print "\""
			dialogue = dialogue(game_status)
			stream_dialogue(dialogue)
			puts "\""
		end
	end

	def dialogue(game_status)
		return "I don't know what to say."
	end
end