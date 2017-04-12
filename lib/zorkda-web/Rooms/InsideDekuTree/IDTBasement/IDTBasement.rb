module Zorkda
  module Rooms

    #DONE
    class IDTBasement < Room

			def initialize(floor, name)
				super()
				@name = name
				@floor = floor
				@description = nil
				@location = "Inside the Deku Tree"
				@uside.change_type(:ceiling)
			end
		end

  end
end