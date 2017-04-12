module Zorkda
	module Actors

    #DONE
		class Chest < TerrainItem
			
			attr_accessor :is_open, :boss_key_needed
			
			def initialize(name, description, distance, contents)
				super(name, description, distance)
				@contents = contents
				@hookshotable = true
				@can_pick_up = false
				@breakable = false
				@openable = true
				@gen_singular = "chest"
				@gen_plural = "chests"
				@parent_alias = false
				@parent_singular = nil
				@parent_plural = nil
				@is_open = false
				@boss_key_needed = false
				if @name == nil
					@name = @gen_singular
				end
			end

			def open(player)
				if self.contents.is_a?(Array)
					self.contents = self.contents[0]
				end
				if self.contents.is_a?(Zorkda::Actors::Equipment) || (
					self.contents.is_a?(Zorkda::Actors::InventoryItem) && 
					!self.contents.is_a?(Zorkda::Actors::InventoryAmmo) && 
					!self.contents.is_a?(Zorkda::Actors::Bottle)
				)
					contents = "the #{self.contents.name}!"
				elsif self.contents.gen_singular == self.contents.gen_plural
					contents = "some #{self.contents.name}!"
				else
					contents = "a #{self.contents.name}!"
				end
				Zorkda::GameOutput.add_line("You push back the lid to find #{contents}")
				player.add_to_protagonist(self.contents)
				self.parent_alias = true
				self.parent_singular = name
				self.parent_plural = name
				self.name = "open " + self.name
				self.is_open = true
				self.description = nil
			end
		end

	end
end