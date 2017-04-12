module Zorkda
	module Actors

    #DONE
		class Spiderweb < TerrainItem
			
			def initialize(name, description, distance)
				super(name, description, distance)
				@flammable = true
				@can_pick_up = false
				@breakable = false
				@gen_singular = "spiderweb"
				@gen_plural = "spiderwebs"
				if @name == nil
					@name = @gen_singular
				end
			end

			def light(game_status)
				Zorkda::GameOutput.add_line("The #{self.name} burns away.")
				game_status.curr_room.inventory.delete(self)
			end
		end

	end
end