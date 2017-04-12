module Zorkda
	module Actors

		class BombsWare < Ware
			def initialize(number_per_sale, price)
				super(Zorkda::Actors::Bombs.new, price, number_per_sale, 1.0/0.0)
			end
		end

	end
end