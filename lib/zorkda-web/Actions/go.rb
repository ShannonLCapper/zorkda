module Zorkda
	module Actions

		def self.go(game_status, side)
			curr_room = game_status.curr_room
			player = game_status.player
			move_counter = game_status.move_counter
			brief = game_status.brief
			if side == "north" || side == "n"
				side = curr_room.nside
			elsif side == "south" || side == "s"
				side = curr_room.sside
			elsif side == "west" || side == "w"
				side = curr_room.wside
			elsif side == "east" || side == "e"
				side = curr_room.eside
			elsif side == "up" || side == "u"
				side = curr_room.uside
			elsif side == "down" || side == "d"
				side = curr_room.dside
			else
				Zorkda::GameOutput.add_line("I only understand &quot;go&quot; plus a direction.")
				return
			end
			if side.distance > 0
				Zorkda::GameOutput.add_line("That path is currently out of your reach.")
			elsif (side.is_a?(Zorkda::Rooms::Waterway) || side.is_a?(Zorkda::Rooms::BlockableWaterPath)) && side == curr_room.dside && 
			(player.weight < 2 || player.diving_distance < side.submerged_distance)
				Zorkda::GameOutput.add_line("That path is too far under the water for you to reach by diving.")
			elsif side.is_a?(Zorkda::Rooms::Barrier)
				Zorkda::GameOutput.add_line("You can't go that way. #{side.error}")
			elsif side.is_a?(Zorkda::Rooms::Crawlway) && player.age == "adult"
				Zorkda::GameOutput.add_line("I think you're a little too big to fit through there.")
			elsif side.is_a?(Zorkda::Rooms::BlockablePath) && side.blocked
				Zorkda::GameOutput.add_line("#{side.blocked_attempt_message}")
				if side.blocked_damage > 0
					player.receive_damage(game_status, side.blocked_damage)
				end
				if side.on_fire
					player.on_fire
				elsif side.frozen
					player.freeze(move_counter)
				end
			elsif side.is_a?(Zorkda::Rooms::Waterway) && side == curr_room.uside && player.weight > 1
				Zorkda::GameOutput.add_line("You aren't buoyant enough to go that way.")
			elsif curr_room.underwater && (side.is_a?(Zorkda::Rooms::Door) || side.is_a?(Zorkda::Rooms::LockableDoor) || 
			side.is_a?(Zorkda::Rooms::BarrableDoor)) && player.weight < 2
				Zorkda::GameOutput.add_line("You can't go through a door while you're floating around.")
			elsif side.is_a?(Zorkda::Rooms::Crawlway) && player.deku_sticks.on_fire
				Zorkda::GameOutput.add_line("It's not safe to go through that narrow crawl space with a lit deku stick.")
			else
				game_status.curr_room = side.goes_to
				Zorkda::Engine.enter_room(game_status)
			end
		end

	end
end