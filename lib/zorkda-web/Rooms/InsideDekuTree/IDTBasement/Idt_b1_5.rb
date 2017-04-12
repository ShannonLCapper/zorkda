module Zorkda
  module Rooms

    #DONE
    class Idt_b1_5 < IDTBasement

			attr_accessor :wall, :web

			def initialize
				super("B1", "Larva Room")
				@description = "You stand in a large spiderweb-coated room with a musty sort of smell."
				@eside = BlockablePath.new("east", "there is a small crawl space with a spiderweb over the opening", "there is a small crawl space", true, "The spiderweb over the opening is too thick to go through.")
				@sside = Door.new("south")
				@nside = BreakableSide.new("north")
				@inventory = [
					Zorkda::Actors::BreakableWall.new("north", 0),
					Zorkda::Actors::Spiderweb.new("spiderweb over the crawl space", nil, 0),
					Zorkda::Actors::Torch.new(nil, nil, 0, true),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
				@web = @inventory[1]
				@wall = @inventory[0]
				@web.display = false
				@enemies = [
					Zorkda::Actors::GohmaEgg.new(nil, "A grotesque Gohma egg lays on the floor, pulsating.", 0),
					Zorkda::Actors::GohmaEgg.new(nil, nil, 0),
					Zorkda::Actors::GohmaEgg.new(nil, nil, 0),
					Zorkda::Actors::WitheredDekuBaba.new(nil, nil, 0)			
				]
			end

			def update_locks(game_status)
				if !self.inventory.include?(self.wall) && self.nside.blocked
					self.nside.unblock
				end
				if !self.inventory.include?(self.web) && self.eside.is_a?(Blockable_path) && self.eside.blocked
					self.eside = Crawlway.new("east")
					self.eside.goes_to = game_status.child_rooms[:idt_b1_sewer_west]
				end
			end

		end

  end
end