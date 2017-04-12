module Zorkda
	module Actors

    #DONE
		class BreakableWall < TerrainItem

			def initialize(direction, distance)
				super(direction + " wall", nil, distance)
				@gen_singular = "wall"
				@gen_plural = "walls"
				@parent_alias = true
				@parent_singular = "fragile wall"
				@parent_plural = "fragile walls"
				@can_pick_up = false
				@breakable = true
				@display = false
				@effective_items = ["bomb"]
			end

			def break(curr_room, player)
				Zorkda::GameOutput.add_line("The #{self.name} breaks away, revealing an opening behind it.")
				curr_room.inventory.delete(self)
			end
		end

	end
end