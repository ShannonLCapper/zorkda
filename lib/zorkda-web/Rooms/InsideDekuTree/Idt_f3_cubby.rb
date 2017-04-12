module Zorkda
  module Rooms

    #DONE
    class Idt_f3_cubby < InsideDekuTree

			def initialize
				super("F3", "Cubby")
				@description = "You stand in a small cubby in the wall."
				@nside = Opening.new("north")
				@inventory = [
          Zorkda::Actors::Chest.new(
            "small chest", 
            nil, 
            0, 
            [Zorkda::Actors::Heart.new(nil, nil, 0)])
        ]
				@enemies = [
          Zorkda::Actors::GoldSkulltula.new(nil, "A gold skulltula crawls on the wall", 0)
        ]
			end
		end

  end
end