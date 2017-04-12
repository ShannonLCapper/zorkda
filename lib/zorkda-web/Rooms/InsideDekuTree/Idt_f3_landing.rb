module Zorkda
  module Rooms

    #DONE
    class Idt_f3_landing < InsideDekuTree

			def initialize
				super("F3", "Landing")
				@description = "You're on a cramped wooden landing coated in spiderwebs."
				@dside = Vines.new("down")
				@wside = Opening.new("west")
			end
		end

  end
end