module Zorkda
	module Actors

		class HeartPieceWare < Ware
			def initialize(price)
				super(Zorkda::Actors::HeartPiece.new(nil, nil, 0), price, 1, 1)
			end
		end

	end
end