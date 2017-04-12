module Zorkda
	module Engine

    def self.respawn_player(game_status)
      game_status.player.respawn
      if game_status.curr_room.respawn_point
        room_to_respawn_in = game_status.curr_room.respawn_point
      else
        if game_status.player.age == "child"
          room_to_respawn_in = game_status.child_rooms[:links_house]
        else
          #room_to_respawn_in = game_status.adult_rooms[:temple_of_time]
        end
      end
      game_status.curr_room = room_to_respawn_in
      self.enter_room(game_status)
    end

	end
end