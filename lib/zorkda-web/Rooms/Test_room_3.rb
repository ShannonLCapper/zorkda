module Zorkda
  module Rooms

    #DONE
    class Test_room_3 < Room

    	def initialize
    		super()
    		@name = "Test Room 3"
    		@eside = Door.new("east")
    	end
    end

  end
end