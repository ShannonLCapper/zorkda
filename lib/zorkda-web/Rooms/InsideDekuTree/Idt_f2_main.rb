module Zorkda
  module Rooms

    #DONE
    class Idt_f2_main < InsideDekuTree

			def initialize
				super("F2", "Main Trunk")
				@description = "You stand on a narrow pathway along the perimeter of the trunk."
				@dside = Ladder.new("down")
				@uside = SpiderVines.new("up")
				@wside = Door.new("west")
				@inventory = [
          Zorkda::Actors::Chest.new(
            nil, 
            nil, 
            0, 
            [Zorkda::Actors::YellowRupee.new(nil, nil, 0)]
          ), 
          Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"), 
          Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")]
				@enemies = [Zorkda::Actors::Skullwalltula.new(nil, nil, 5)]
				@enemies[0].display = false
				@navi_hint = "Those vines look pretty sturdy. Maybe you can climb them with &quot;go up&quot;."
			end

			def update_locks(game_status)
				if self.enemies.length == 0 && self.uside.blocked
					Zorkda::GameOutput.add_line("You can now go up the vines.")
					self.uside.unblock
				end
			end

			def update_navi_hint(game_status)
				if self.visited_before
					self.navi_hint = nil
				end
			end
		end

  end
end