module Zorkda
	module Actors

		#DONE
		class TalkingDekuScrub < DekuScrub

			attr_accessor :surrender_dialogue

			def initialize(name, description, distance, surrender_dialogue)
				super(name, description, distance)
				@surrender_dialogue = surrender_dialogue
			end

			def get_hit(game_status, weapon_type, damage_enemy, injure_message)
				curr_room = game_status.curr_room
				move_counter = game_status.move_counter
				if self.effective_items.include?(weapon_type)
					if self.can_hide_from.include?(weapon_type)
						Zorkda::GameOutput.add_line("As you approach, #{self.name} ducks into the bushes, making you unable to reach it.")
					else
						self.surrender
						curr_room.enemies.delete(self)
						curr_room.inventory << Zorkda::Actors::Heart.new(nil, nil, false)
					end
				end
				if self.stunned_by.include?(weapon_type) && curr_room.enemies.include?(self)
					self.stun(move_counter)
				end
			end

			def surrender
				Zorkda::GameOutput.new_paragraph
				Zorkda::GameOutput.add_line("#{self.name}: &quot;")
				Zorkda::GameOutput.append_text(self.surrender_dialogue)
				Zorkda::GameOutput.append_text("&quot;")
				Zorkda::GameOutput.new_paragraph
				Zorkda::GameOutput.add_line("And with that, the Deku scrub flees the room, leaving a heart behind.") 
			end

		end

	end
end