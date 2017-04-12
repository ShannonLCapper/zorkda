module Zorkda
	module Actors

    #DONE
		class GoronShopkeeper < Shopkeeper

			def initialize
				super(
					"Goron", 
					nil, 
					[
						Zorkda::Actors::BombsWare.new(5, 25), 
						Zorkda::Actors::BombsWare.new(10, 50), 
						Zorkda::Actors::BombsWare.new(20, 80), 
						Zorkda::Actors::BombsWare.new(30, 120), 
						Zorkda::Actors::GoronTunicWare.new(200), 
						Zorkda::Actors::HeartWare.new(10)
					]
				)
			end
		end

	end
end