module Zorkda
	module Actors

    #DONE
		class ZoraShopkeeper < Shopkeeper

			def initialize
				super(
					"Zora", 
					nil, 
					[
						Zorkda::Actors::ArrowsWare.new(10, 20), 
						Zorkda::Actors::ArrowsWare.new(30, 60), 
						Zorkda::Actors::ArrowsWare.new(50, 90), 
						Zorkda::Actors::DekuNutsWare.new(5, 15), 
						Zorkda::Actors::ZoraTunicWare.new(300)
					]
				)
			end
		end

	end
end