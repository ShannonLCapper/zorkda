module Zorkda
	module Actors

    #DONE
		class BazaarShopkeeper < Shopkeeper

			def initialize
				super(
					"Hylian", 
					nil, 
					[
						Zorkda::Actors::ArrowsWare.new(10, 20), 
						Zorkda::Actors::ArrowsWare.new(30, 60), 
						Zorkda::Actors::ArrowsWare.new(50, 90), 
						Zorkda::Actors::BombsWare.new(5, 35), 
						Zorkda::Actors::DekuNutsWare.new(5, 15),
						Zorkda::Actors::DekuStickWare.new(10), 
						Zorkda::Actors::HylianShieldWare.new(80), 
						Zorkda::Actors::HeartWare.new(10)
					]
				)
			end
		end

	end
end