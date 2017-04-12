module Zorkda
	module Actors

    #DONE
		class KokiriShopkeeper < Shopkeeper

			def initialize
				super(
					"Kokiri", 
					nil, 
					[
						Zorkda::Actors::ArrowsWare.new(10, 20), 
						Zorkda::Actors::ArrowsWare.new(30, 60), 
						Zorkda::Actors::DekuNutsWare.new(5, 15), 
						Zorkda::Actors::DekuNutsWare.new(10, 30), 
						Zorkda::Actors::DekuSeedsWare.new(30, 30), 
						Zorkda::Actors::DekuShieldWare.new(40), 
						Zorkda::Actors::DekuStickWare.new(10), 
						Zorkda::Actors::HeartWare.new(10)
					]
				)
			end
		end

	end
end