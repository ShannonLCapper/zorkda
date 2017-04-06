module Zorkda
  module Engine

  	def self.get_location(room)
      return {
        area: room.location,
        room: room.name
      }
  	end

  end
end