module Zorkda
	module Actors

		class DekuStickWare < Ware
			def initialize(price)
				super(Zorkda::Actors::DekuStick.new, price, 1, 1.0/0.0)
				@child_only = true
			end
		end

	end
end