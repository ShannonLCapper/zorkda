module Zorkda
  module Rooms

    #DONE
    class InsideDekuTree < Room

    	def initialize(floor, name)
    		super()
    		@name = name
    		@floor = floor
    		@description = nil
    		@location = "Inside the Deku Tree"
    		@nside.change_type(:wooden_wall)
    		@sside.change_type(:wooden_wall)
    		@eside.change_type(:wooden_wall)
    		@wside.change_type(:wooden_wall)
    		@uside.change_type(:ceiling)
    	end

    end

  end
end