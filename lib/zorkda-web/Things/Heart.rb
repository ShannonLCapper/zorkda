class Heart < Thing

	attr_accessor :name, :gen_plural, :gen_singular, :value, :description, :quantity, :quantity_allowed,
	:parent_alias, :parent_singular, :parent_plural, :spawn_frequency

	def initialize(name, description, respawn)
		super()
		@gen_plural = "hearts"
		@gen_singular = "heart"
		if name == nil
			@name = @gen_singular
		else
			@name = name
		end
		@value = 1
		@distance = distance
		@original_distance = 0
		@weight = 0
		@can_pick_up = true
		@can_push = false
		@description = description
		@respawn = respawn
		@visible = true
		@quantity = 1
		@hittable = false
		@quantity_allowed = 1.0/0.0
		@parent_alias = false
		@parent_plural = nil
		@parent_singular = nil
		@can_roll_into = true
		@spawn_frequency = 8
	end

	def pick_up(game_status)
		game_status.player.add_to_protagonist(self)
		if self.respawn
			game_status.curr_room.respawn << self
		end
		game_status.curr_room.inventory.delete(self)
	end
end

class Heart_piece < Thing

	attr_accessor :name, :gen_plural, :gen_singular, :value, :description, :respawn, :quantity, :quantity_allowed,
	:parent_alias, :parent_singular, :parent_plural

	def initialize(name, description, distance)
		super()
		@gen_plural = "heart pieces"
		@gen_singular = "heart piece"
		if name == nil
			@name = @gen_singular
		else
			@name = name
		end
		@value = 1
		@distance = distance
		@original_distance = distance
		@weight = 0
		@can_pick_up = true
		@can_push = false
		@description = description
		@respawn = false
		@visible = true
		@quantity = 1
		@quantity_allowed = 1.0/0.0
		@parent_alias = false
		@parent_plural = nil
		@parent_singular = nil
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

class Heart_container < Heart_piece
	
	def initialize (name, description, distance)
		super(name, distance, description)
		@gen_plural = "heart containers"
		@gen_singular = "heart container"
		if name == nil
			super(@gen_singular, description, distance)
		else
			super(name, description, distance)
		end
		@value = 4
	end
end