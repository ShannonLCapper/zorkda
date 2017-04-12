module Zorkda
  module Rooms

    #DONE
    class Kf_shop < Room

			def initialize
				super()
				@name = "Kokiri Shop"
				@description = nil
				@nside.change_type(:counter)
				@sside = Door.new("south")
				@eside.change_type(:wooden_wall)
				@wside.change_type(:wooden_wall)
				@uside.change_type(:ceiling)
				@characters = [
					Zorkda::Actors::KokiriShopkeeper.new
				]
			end
		end

	end
end