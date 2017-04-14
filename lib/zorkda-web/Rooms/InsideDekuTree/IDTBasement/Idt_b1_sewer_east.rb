module Zorkda
  module Rooms

    #DONE
    class Idt_b1_sewer_east < IDTBasement

			attr_accessor :torch, :chest, :corner_web, :switch, :door_web

			def initialize
				super("B1", "Sewer (East end)")
				@description = "You're standing in what looks like an old, damp sewer."
				@sside = BlockablePath.new(
          "south", 
          "there is a door coated in spiderwebs", 
          "there is a door", 
          true, 
          "you try to push past the spiderwebs, but they are too thick."
        )
				@wside = HighLedge.new("west")
				@wside.set_distance(2)
				@uside = Vines.new("up")
				@has_entry_cutscene = true
				@inventory = [
					Zorkda::Actors::FloorSwitchSticky.new(nil, nil, 0, 1, 1.0/0.0), 
					Zorkda::Actors::Torch.new(nil, nil, 1, false),
					Zorkda::Actors::Chest.new(
            nil, 
            nil, 
            1, 
            [Zorkda::Actors::Heart.new(nil, nil, false)]
          ),
					Zorkda::Actors::Spiderweb.new(
            "corner spiderweb", 
            "A spiderweb in the corner blocks off a chest and an unlit torch.", 
            0
          ),
					Zorkda::Actors::Spiderweb.new("door spiderweb", nil, 0),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
				@switch = @inventory[0]
				@torch = @inventory[1]
				@chest = @inventory[2]
				@corner_web = @inventory[3]
				@door_web = @inventory[4] 
				@torch.display = false
				@chest.display = false
				@door_web.display = false
				@enemies = [
					Zorkda::Actors::GoldSkulltula.new(nil, nil, 5),
					Zorkda::Actors::GoldSkulltula.new(nil, nil, 5),
					Zorkda::Actors::DekuBaba.new(nil, nil, 0)
				]
			end

			def entry_cutscene(game_status)
				dialogue =
					"You plummet downward through the air with a scream. " +
					"You fall onto the thick spiderweb coating the floor on the ground level, " +
					"and your momentum is sufficient to rip through the spiderweb. " +
					"You drop one more story and land in a pool of murky water."
				Zorkda::GameOutput.add_line(dialogue)
				game_status.child_rooms[:idt_f1_main].dside.unblock
				game_status.child_rooms[:idt_f1_main].navi_hint = nil
			end

			def update_distances(game_status)
				# if self.wside.distance == 1
				# 	self.inventory.each do |item|
				# 		if item.is_a?(Zorkda::Actors::Block)
				# 			self.wside.distance = 0
				# 			break
				# 		end
				# 	end
				# end
				if self.switch.activated && !self.torch.on_fire
					Zorkda::GameOutput.add_line("The torch flares to life, burning away the spiderweb in the corner.")
					self.torch.display = true
					self.chest.display = true
					self.move_all_closer
					self.inventory.delete(self.corner_web)
          Zorkda::GameOutput.suppress_text_additions
					self.torch.light(game_status)
          Zorkda::GameOutput.unsuppress_text_additions
				end
			end

			def update_locks(game_status)
				if !self.inventory.include?(self.door_web) && self.sside.blocked
					Zorkda::GameOutput.add_line("You can now go south.")
					self.sside.unblock
				end
			end

		end

  end
end