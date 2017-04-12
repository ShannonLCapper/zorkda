module Zorkda
	module Actors

		#DONE
		class DekuScrubBrother < DekuScrub

			def initialize(name)
				super(name, nil, 0)
				@destun_time = 1.0/0.0
				@can_hide_from = ["sword", "stick", "hammer", "bow"]
			end

			def stun(move_counter)
				self.stunned = true
				self.moves_when_stunned = move_counter
				self.effective_items = []
				self.stunned_by = []
				self.can_hide_from = []
				if self.attacking
					self.terminate_attack
				end
			end

			def destun
				if self.stunned
					self.stunned = false
					self.moves_when_stunned = nil
					self.effective_items = ["bow", "sword", "stick", "hammer"]
					self.stunned_by = ["nut", "boomerang", "hookshot", "bomb"]
					self.can_hide_from = ["sword", "stick", "hammer"]
				end
			end

			def block(game_status)
				Zorkda::GameOutput.add_line("You rebound #{self.name}'s projectile back at it, stunning it in place.")
				self.stun(game_status.move_counter)
			end
		end

	end
end