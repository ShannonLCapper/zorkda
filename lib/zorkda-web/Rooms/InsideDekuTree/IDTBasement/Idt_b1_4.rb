module Zorkda
  module Rooms

    #DONE
    class Idt_b1_4 < IDTBasement

			def initialize
				super("B1", "Torch Room")
				@description = nil
				@eside = BarrableDoor.new("east", false)
				@nside = BarrableDoor.new("north", false)
				@inventory = [
					Zorkda::Actors::Torch.new("big torch", nil, 0, true),
					Zorkda::Actors::Torch.new("small torch 1", nil, 0, false),
					Zorkda::Actors::Torch.new("small torch 2", nil, 0, false),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
				@enemies = [
					Zorkda::Actors::DekuBaba.new(nil, nil, 0),
					Zorkda::Actors::WitheredDekuBaba.new(nil, nil, 0)
				]
			end

			def update_locks(game_status)
				if self.inventory[1].on_fire && self.inventory[2].on_fire && self.eside.blocked
					Zorkda::GameOutput.add_line("The bars lift from both doors.")
					self.eside.unblock
					self.nside.unblock
				elsif !self.inventory[1].on_fire && !self.inventory[2].on_fire && !self.eside.blocked
					Zorkda::GameOutput.add_line("Heavy bars slam over both doors.")
					self.eside.block
					self.nside.block
				end
			end
		end

  end
end