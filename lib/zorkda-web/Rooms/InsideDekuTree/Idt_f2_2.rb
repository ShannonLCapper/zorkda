module Zorkda
  module Rooms

    #DONE
    class Idt_f2_2 < InsideDekuTree

      def initialize
        super("F2", "Corridor")
        @description = "You stand in a narrow corridor."
        @wside = BarrableDoor.new("west", false)
        @eside = BarrableDoor.new("east", false)
        @enemies = [
          Zorkda::Actors::DekuScrub.new(
            nil, 
            "A deku scrub watches you from the middle of the room, its body buried in bushes.", 
            0
          )
        ]
        @enemies[0].random_contents = false
        @enemies[0].contents = [Zorkda::Actors::Heart.new(nil, nil, false)]
      end

      def update_locks(game_status)
        if self.enemies.length == 0 && self.wside.blocked
          Zorkda::GameOutput.add_line("The bars lift from the doors.")
          self.wside.unblock
          self.eside.unblock
        elsif self.enemies.length > 0 && !self.wside.blocked
          Zorkda::GameOutput.add_line("Heavy bars slam over both doors.")
          self.wside.block
          self.eside.block
        end
      end
    end

  end
end