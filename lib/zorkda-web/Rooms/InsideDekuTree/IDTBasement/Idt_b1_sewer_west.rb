module Zorkda
  module Rooms

    #DONE
    class Idt_b1_sewer_west < IDTBasement

			attr_accessor :web, :blok

			def initialize
				super("B1", "Sewer (West end)")
				@description = "You are standing in what looks like an old, damp sewer."
				@wside = Crawlway.new("west")
				@eside = Dropoff.new("east")
				@dside = BlockablePath.new(
					"down",
					"there is a large hole covered in thick spiderweb",
					"there is a large hole",
					true,
					"The thick spiderweb stretches, but does not give way.")
				@inventory = [
					Zorkda::Actors::Spiderweb.new("spiderweb over the large hole", nil, 0),
					Zorkda::Actors::Block.new(nil, "A block sits a short distance from the dropoff.", "A block sits against the west ledge.", 0, false, true)
				]
				@web = @inventory[0]
				@blok = @inventory[1]
				@web.display = false
				@enemies = [
					Zorkda::Actors::DekuBaba.new(nil, nil, 0),
					Zorkda::Actors::WitheredDekuBaba.new(nil, nil, 0)
				]
			end

			def update_locks(game_status)
				if self.inventory.include?(self.blok) && self.blok.slid
					Zorkda::GameOutput.add_line("The block falls off the ledge, making a bridge between the east and west ends of the room.")
					self.inventory.delete(self.blok)
					game_status.child_rooms[:idt_b1_sewer_east].inventory << self.blok
					game_status.child_rooms[:idt_b1_sewer_east].wside.distance = 0
				end
				if !self.inventory.include?(self.web) && self.dside.blocked
					Zorkda::GameOutput.add_line("You can now go down.")
					self.dside.unblock
				end
			end
		end

  end
end