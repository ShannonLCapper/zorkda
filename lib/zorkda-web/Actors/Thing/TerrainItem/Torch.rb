module Zorkda
	module Actors

    #DONE
		class Torch < TerrainItem

			attr_accessor :moves_when_activated, :moves_to_reset
			
			def initialize(name, description, distance, on_fire)
				super(name, description, distance)
				@on_fire = on_fire
				@moves_when_activated = nil
				@moves_to_reset = 1.0/0.0
				@flammable = true
				@can_pick_up = false
				@breakable = false
				@hookshotable = true
				@gen_singular = "torch"
				@gen_plural = "torches"
				@has_parenthetical_name = true
				if on_fire
					@parenthetical_name = "lit"
				else
					@parenthetical_name = "unlit"
				end
				if @name == nil
					@name = @gen_singular
				end
			end

			def light(game_status)
				if self.on_fire
					Zorkda::GameOutput.add_line("The #{self.name} is already lit.")
				else
					Zorkda::GameOutput.add_line("The #{self.name} is now lit.")
					self.on_fire = true
					self.moves_when_activated = game_status.move_counter
					self.parenthetical_name = "lit"
				end
			end
		end

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