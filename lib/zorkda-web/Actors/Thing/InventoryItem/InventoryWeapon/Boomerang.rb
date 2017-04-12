module Zorkda
	module Actors

		class Boomerang < InventoryWeapon

			def initialize
				super("Boomerang", "Boomerang", "Boomerangs", 1, 5)
				@type = "boomerang"
				@acquired_description = "With this weapon, you can hit distant enemies using the commands &quot;hit&quot;, &quot;break&quot;, and &quot;throw&quot;."
				@can_throw = true
				@available_as_adult = false
			end

			def use_item(game_status, target)
				curr_room = game_status.curr_room
				player = game_status.player
				move_counter = game_status.move_counter
				if curr_room.underwater
					Zorkda::GameOutput.add_line("You can't use the boomerang underwater.")
				elsif target == nil
					Zorkda::GameOutput.add_line("You need to throw the boomerang at something.")
				else
					Zorkda::GameOutput.add_line("I don't have the code to do that yet.")
				end
			end
		end

	end
end