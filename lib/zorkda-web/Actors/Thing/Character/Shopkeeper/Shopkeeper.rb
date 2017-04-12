module Zorkda
	module Actors

  	#DONE
		class Shopkeeper < Character

			attr_accessor :wares, :gender

			def initialize(race, description, wares)
				if description == nil
					super(
						"#{race} Shopkeeper",
						description = "A #{race} shopkeeper stands behind the counter, with wares stacked on the back shelves.",
						race,
						0,
						"shopkeeper",
						"shopkeepers"
					)
				else
					super("#{race} Shopkeeper", description, race, 0, "shopkeeper", "shopkeepers")
				end
				@wares = wares
			end

			def dialogue(game_status)
				if wares.length == 0
					return "Welcome to my shop! Unfortunately, I don't currently have anything for sale. Sorry!"
				end
				text_lines = ["Welcome to my shop! This is what I have for sale:"]
				self.wares.each do |ware|
					text_line = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;#{ware.name}"
					if ware.inventory_quantity > 0
						text_line += ": #{ware.price.to_i} "
						text_line += ware.price == 1 ? "rupee" : "rupees"
					else
						text_line += ": SOLD OUT"
					end
					text_lines << text_line
				end
				text_lines << "You can buy something by typing &quot;buy&quot; and the name of the item you want."
				return text_lines
			end

			def sold_out_dialogue(ware)
				Zorkda::GameOutput.add_line("#{self.name}: &quot;Sorry kid, we're all sold out of #{ware.gen_plural}.&quot;")
			end

			def item_not_found_dialogue
				Zorkda::GameOutput.add_line("#{self.name}: &quot;Whatever that is, we don't have any for sale.&quot;")
			end

			def cant_afford_dialogue
				Zorkda::GameOutput.add_line("#{self.name}: &quot;It looks like that costs a little more than you can afford.&quot;")
			end

			def take_ware(ware)
				ware.inventory_quantity -= 1
			end
		end

	end
end