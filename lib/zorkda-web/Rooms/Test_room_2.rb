module Zorkda
  module Rooms

    #DONE
    class Test_room_2 < Room

    	def initialize
    		super()
    		@name = "Test Room 2"
    		@sside = Door.new("south")
    	end
    end

  end
end