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

class Heart_ware < Ware

	def initialize(price)
		super(Heart.new(nil, nil, true), price, 1, 1.0/0.0)
	end
end

class Heart_piece_ware < Ware

	def initialize(price)
		super(Heart_piece.new(nil, nil, 0), price, 1, 1)
	end
end

class Bombs_ware < Ware

	def initialize(number_per_sale, price)
		super(Bombs.new, price, number_per_sale, 1.0/0.0)
	end
end

class Deku_seeds_ware < Ware

	def initialize(number_per_sale, price)
		super(Deku_seeds.new, price, number_per_sale, 1.0/0.0)
		@child_only = true
	end
end

class Deku_stick_ware < Ware

	def initialize(price)
		super(Deku_stick.new, price, 1, 1.0/0.0)
		@child_only = true
	end
end

class Deku_nuts_ware < Ware

	def initialize(number_per_sale, price)
		super(Deku_nuts.new, price, number_per_sale, 1.0/0.0)
	end
end

class Arrows_ware < Ware

	def initialize(number_per_sale, price)
		super(Arrows.new, price, number_per_sale, 1.0/0.0)
		@adult_only = true
	end
end

class Deku_shield_ware < Ware

	def initialize(price)
		super(Deku_shield.new, price, 1, 1.0/0.0)
		@child_only = true
	end
end

class Hylian_shield_ware < Ware

	def initialize(price)
		super(Hylian_shield.new, price, 1, 1.0/0.0)
		@adult_only = true
	end
end

class Goron_tunic_ware < Ware

	def initialize(price)
		super(Goron_tunic.new, price, 1, 1.0/0.0)
		@adult_only = true
	end
end

class Zora_tunic_ware < Ware

	def initialize(price)
		super(Zora_tunic.new, price, 1, 1.0/0.0)
		@adult_only = true
	end
end