module Zorkda
	module Actors

    #DONE
		class Grass < TerrainItem

			def initialize(name, description, distance, contents)
				super(name, description, distance)
				if contents.is_a?(String) && contents.upcase == "RNG"
					@random_contents = true
					@contents = nil
				else
					@contents = contents
				end
				@can_pick_up = false
				@cuttable = true
				@breakable = false
				@gen_singular = "grass"
				@gen_plural = "grass"
				@effective_items = ["sword"]
				@respawn = true
				if @name == nil
					@name = @gen_singular
				end
			end

			def cut(game_status)
				curr_room = game_status.curr_room
				player = game_status.player
				if self.cuttable
					if self.contents != nil && self.contents.length > 0
						text_line = "You cut the #{self.name}, which gives you the following: "
            (self.contents.length - 1).times do |i|
              separator = self.contents.length > 2 ? ", " : " "
              text_line += self.contents[i].name + separator
            end
            text_line += "and " if self.contents.length > 1
            text_line += "#{self.contents.last.name}"
            Zorkda::GameOutput.add_line(text_line)
						self.contents.each do |item|
							player.add_to_protagonist(item)
						end
					else
						Zorkda::GameOutput.add_line("You cut the #{self.name}, but nothing was in it.")
					end
					if self.respawn
						curr_room.respawn << self
					end
					curr_room.inventory.delete(self)
				end
			end
		end

	end
end