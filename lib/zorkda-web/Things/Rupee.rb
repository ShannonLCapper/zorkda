class Rupee < Thing
	
	attr_accessor :name, :parent_alias, :parent_plural, :parent_singular, :gen_plural, 
	:gen_singular, :value, :description

	def initialize(name, description, respawn)
		super()
		@name = name
		@parent_alias = true
		@parent_plural = "rupees"
		@parent_singular = "rupee"
		@gen_plural = "rupees"
		@gen_singular = "rupee"
		@value = 0
		@distance = 0
		@original_distance = 0
		@weight = 0
		@description = description
		@can_pick_up = true
		@respawn = respawn
		@visible = true
		@hittable = false
		@can_roll_into = true
	end

	def pick_up(game_status)
		game_status.player.add_to_protagonist(self)
		if self.respawn
			game_status.curr_room.respawn << self
		end
		game_status.curr_room.inventory.delete(self)
	end
end

class Green_rupee < Rupee

	attr_accessor :spawn_frequency

	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "green rupees"
		@gen_singular = "green rupee"
		@value = 1
		if @name == nil
			@name = @gen_singular
		end
		@spawn_frequency = 8
	end
end

class Blue_rupee < Rupee

	attr_accessor :spawn_frequency

	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "blue rupees"
		@gen_singular = "blue rupee"
		@value = 5
		if @name == nil
			@name = @gen_singular
		end
		@spawn_frequency = 2
	end

end

class Yellow_rupee < Rupee

	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "yellow rupees"
		@gen_singular = "yellow rupee"
		@value = 10
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Red_rupee < Rupee
	
	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "red rupees"
		@gen_singular = "red rupee"
		@value = 20
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Purple_rupee < Rupee

	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "purple rupees"
		@gen_singular = "purple rupee"
		@value = 50
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Orange_rupee < Rupee

	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "orange rupees"
		@gen_singular = "orange rupee"
		@value = 100
		if @name == nil
			@name = @gen_singular
		end
	end
end

class Silver_rupee < Rupee

	def initialize(name, description, respawn)
		super(name, description, respawn)
		@gen_plural = "silver rupees"
		@gen_singular = "silver rupee"
		@value = 200
		if @name == nil
			@name = @gen_singular
		end
	end
end