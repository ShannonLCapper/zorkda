module Zorkda
	module Actors

    #DONE
    class TemporaryTorch < Torch

      def initialize(name, description, distance, moves_to_reset)
        super(name, description, distance, false)
        @moves_to_reset = moves_to_reset
      end

      def update_if_should_go_out(move_counter)
        if self.on_fire && move_counter > self.moves_when_activated + self.moves_to_reset
          Zorkda::GameOutput.add_line("The #{self.name} went out.")
          self.on_fire = false
          self.moves_when_activated = nil
          self.parenthetical_name = "unlit"
        end
      end
    end

	end
end