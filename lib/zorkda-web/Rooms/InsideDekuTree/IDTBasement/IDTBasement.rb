module Zorkda
  module Rooms

    #DONE
    class IDTBasement < InsideDekuTree

			def initialize(floor, name)
				super(floor, name)
        @nside.change_type(:stone_wall)
        @sside.change_type(:stone_wall)
        @eside.change_type(:stone_wall)
        @wside.change_type(:stone_wall)
			end
		end

  end
end