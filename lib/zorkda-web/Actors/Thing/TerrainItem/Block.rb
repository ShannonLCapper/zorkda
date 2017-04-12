module Zorkda
	module Actors

    #DONE
		class Block < TerrainItem
			
			attr_accessor :slid, :unslid_desc, :slid_desc, :when_moved, :can_slide_back, :path_clear
			
			def initialize(name, unslid_desc, slid_desc, distance, can_slide_back, path_clear)
				@unslid_desc = unslid_desc
				@slid_desc = slid_desc
				super(name, unslid_desc, distance)
				@slid = false
				@path_clear = path_clear
				@can_slide = true
				@can_slide_back = can_slide_back
				@can_pick_up = false
				@breakable = false
				@gen_plural = "blocks"
				@gen_singular = "block"
				@when_moved = nil
				if @name == nil
					@name = @gen_singular
				end
			end

			def slide(move_counter)
				self.slid = true
				self.description = self.slid_desc
				self.when_moved = move_counter
				
			end

			def unslide(move_counter)
				self.slid = false
				self.description = self.unslid_desc
				self.when_moved = move_counter
			end
		end


	end
end