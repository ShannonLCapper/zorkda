module Zorkda
	module Actors

		class DekuShieldWare < Ware
			def initialize(price)
				super(Zorkda::Actors::DekuShield.new, price, 1, 1.0/0.0)
				@child_only = true
			end
		end

	end
end