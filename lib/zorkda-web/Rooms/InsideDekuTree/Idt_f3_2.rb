module Zorkda
  module Rooms

    #DONE
    class Idt_f3_2 < InsideDekuTree

			attr_accessor :switch, :torch, :spider, :platforms_up

			def initialize
				super("F3", "Platform Room")
				@description = "You stand at the bottom of a ditch in the room."
				@eside = BarrableDoor.new("east", false)
				@sside = SpiderHighCubby.new("south")
				@inventory = [
					Zorkda::Actors::Torch.new("right torch", nil, 0, true),
					Zorkda::Actors::Torch.new("left torch", nil, 0, false),
					Zorkda::Actors::FloorSwitchSticky.new(
            nil, 
            "There is a switch on the floor nearby.", 
            0, 
            1, 
            4
          ),
					Zorkda::Actors::Chest.new(
            "far chest", 
            "A chest sits on the high land at the far end of the room.", 
            1, 
            [Zorkda::Actors::YellowRupee.new(nil, nil, 0)]
          ),
					Zorkda::Actors::Weed.new(nil, nil, 1, "RNG"),
					Zorkda::Actors::Weed.new(nil, nil, 1, "RNG")
				]
				@switch = @inventory[2]
				@torch = @inventory[1]
				@enemies = [
					Zorkda::Actors::WitheredDekuBaba.new(nil, "A withered deku baba grows next to the chest.", 1),
					Zorkda::Actors::Skulltula.new(nil, nil, 1)
				]
				@spider = @enemies[1]
				@spider.respawn = false
				@spider.display = false
				@platforms_up = false
				@navi_hint = "It looks like that torch on the left was burning not too long ago."
			end

			def update_locks(game_status)
				if self.torch.on_fire && self.eside.blocked
					Zorkda::GameOutput.add_line("The bars lift from the east door.")
					self.eside.unblock
					self.navi_hint = nil
				elsif !self.torch.on_fire && !self.eside.blocked
					Zorkda::GameOutput.add_line("Heavy bars slam over the east door.")
					self.eside.block
				end
				if self.sside.blocked && !self.enemies.include?(self.spider)
					Zorkda::GameOutput.add_line("The south door is now spider free.")
					self.sside.unblock
				elsif !self.sside.blocked && self.enemies.include?(self.spider)
					self.sside.block
				end
			end

			def update_distances(game_status)
				move_counter = game_status.move_counter
				if self.switch.activated && !self.platforms_up
					Zorkda::GameOutput.add_line("Platforms rise from the ditch.")
					self.platforms_up = true
					self.move_all_closer
				elsif !self.switch.activated && self.platforms_up
					self.platforms_up = false
					Zorkda::GameOutput.add_line("The platforms sink back into the ditch.")
					self.move_all_farther_if_needed
        end
			end

		end

  end
end