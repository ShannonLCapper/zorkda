module Zorkda
  module Rooms

    #DONE
    class Idt_b2_antechamber < IDTBasement

			attr_accessor :stun_order

			def initialize
				super("B2", "Antechamber")
				@description = "You stand in a dim room lit by flickering torches with a small pond at one end."
				@uside = Vines.new("up")
				@nside = BarrableDoor.new("north", true)
				@inventory = [
					Zorkda::Actors::Heart.new(nil, nil, 0),
					Zorkda::Actors::Heart.new(nil, nil, 0),
					Zorkda::Actors::Heart.new(nil, nil, 0),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG"),
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
				3.times do |i|
					@inventory[i].submerged = true
				end
				@enemies = [
					Zorkda::Actors::DekuScrubBrother.new("Deku scrub 3"),
					Zorkda::Actors::DekuScrubBrother.new("Deku scrub 2"),
					Zorkda::Actors::DekuScrubBrother.new("Deku scrub 1")
				]
				@stun_order = []
			end

			def update_locks(game_status)
				self.enemies.each do |enemy|
					if enemy.stunned && !self.stun_order.include?(enemy)
						self.stun_order << enemy
					end
				end
				if self.stun_order == [self.enemies[1], self.enemies[0], self.enemies[2]]
					Zorkda::GameOutput.new_paragraph
					dialogue = [
						"Deku scrub 1 jumps out of hiding.",
						"Deku scrub 1: &quot;" +
						"How did you know our secret?! How irritating! " +
						"It's so annoying that I'm going to reveal the secret of Queen Gohma to you! " +
						"In order to administer to coup de grace to Queen Gohma, " +
						"strike with your sword while she's stunned.",
						"Oh, Queenie... Sorry about that!&quot;",
						" ",
						"And with that, the deku scrubs disappear, leaving a heart behind."
					]
					Zorkda::GameOutput.add_lines(dialogue)
					self.enemies = []
					self.inventory << Zorkda::Actors::Heart.new(nil, nil, false)
					Zorkda::GameOutput.add_line("The bars lift from the north door.")
					self.nside.unblock
				elsif self.stun_order.length == 3
					self.enemies.each do |enemy|
						enemy.destun
					end
					Zorkda::GameOutput.add_line("All three deku scrubs are no longer stunned.")
					self.stun_order = []
				end
			end
		end

  end
end