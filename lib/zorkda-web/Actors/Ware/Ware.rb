module Zorkda
	module Actors

		class Ware

			attr_accessor :name, :item, :price, :quantity_per_sale, :inventory_quantity, :gen_plural, :gen_singular,
			:parent_alias, :parent_singular, :parent_plural,:child_only, :adult_only

			def initialize(item, price, number_per_sale, inventory_quantity)
				@item = item
				@price = price
				@quantity_per_sale = number_per_sale / @item.quantity
				if number_per_sale > 1
					@name = number_per_sale.to_s + " " + @item.gen_plural[0].capitalize + @item.gen_plural[1..-1]
				else
					@name = @item.gen_singular[0].capitalize + @item.gen_singular[1..-1]
				end
				@inventory_quantity = inventory_quantity
				@gen_singular = @item.gen_singular
				@gen_plural = @item.gen_plural
				@parent_alias = @item.parent_alias
				@parent_singular = @item.parent_singular
				@parent_plural = @item.parent_plural
				@child_only = false
				@adult_only = false
			end
		end

	end
end