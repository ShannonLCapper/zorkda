module Zorkda
	module Actors

		class HylianShieldWare < Ware
			def initialize(price)
				super(Zorkda::Actors::HylianShield.new, price, 1, 1.0/0.0)
				@adult_only = true
			end
		end

	end
end