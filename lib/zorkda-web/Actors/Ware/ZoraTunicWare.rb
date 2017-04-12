module Zorkda
	module Actors

		class ZoraTunicWare < Ware
			def initialize(price)
				super(Zorkda::Actors::ZoraTunic.new, price, 1, 1.0/0.0)
				@adult_only = true
			end
		end

	end
end