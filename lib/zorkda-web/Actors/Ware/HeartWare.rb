module Zorkda
	module Actors

		class HeartWare < Ware
			def initialize(price)
				super(Zorkda::Actors::Heart.new(nil, nil, true), price, 1, 1.0/0.0)
			end
		end

	end
end