module Zorkda
	module Actors

		class ArrowsWare < Ware
			def initialize(number_per_sale, price)
				super(Zorkda::Actors::Arrows.new, price, number_per_sale, 1.0/0.0)
				@adult_only = true
			end
		end

	end
end