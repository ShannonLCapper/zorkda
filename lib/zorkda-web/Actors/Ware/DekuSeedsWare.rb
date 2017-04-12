module Zorkda
	module Actors

		class DekuSeedsWare < Ware
			def initialize(number_per_sale, price)
				super(Zorkda::Actors::DekuSeeds.new, price, number_per_sale, 1.0/0.0)
				@child_only = true
			end
		end

	end
end