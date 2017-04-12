module Zorkda
	module Actors

		class GoronTunicWare < Ware
			def initialize(price)
				super(Zorkda::Actors::GoronTunic.new, price, 1, 1.0/0.0)
				@adult_only = true
			end
		end

	end
end