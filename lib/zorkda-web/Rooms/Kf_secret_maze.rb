module Zorkda
  module Rooms

    #DONE
    class KfSecretMaze < Room

			def initialize
				super()
				@name = "???"
				@location = "Kokiri Forest Secret Maze"
				@nside.change_type(:trees)
				@sside.change_type(:trees)
				@eside.change_type(:trees)
				@wside.change_type(:trees)
			end
		end

		class Kf_sm_1 < KfSecretMaze
			def initialize
				super()
				@nside = Crawlway.new("north")
				@eside = Pathway.new("east")
				@inventory = [
					Zorkda::Actors::BlueRupee.new(nil, "a blue rupee lies on the ground", false), 
					Zorkda::Actors::Weed.new(nil, "a weed grows in the center of the clearing", 0, "RNG")
				]
			end
		end

		class Kf_sm_2 < KfSecretMaze
			def initialize
				super()
				@sside = Pathway.new("south")
				@eside = Pathway.new("east")
				@wside = Pathway.new("west")
			end
		end

		class Kf_sm_3 < KfSecretMaze
			def initialize
				super()
				@sside = Pathway.new("south")
				@wside = Pathway.new("west")
				
			end
		end

		class Kf_sm_4 < KfSecretMaze
			def initialize
				super()
				@nside = Pathway.new("north")
				@eside = Pathway.new("east")
				@inventory = [
					Zorkda::Actors::BlueRupee.new(nil, nil, false), 
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")
				]
			end
		end

		class Kf_sm_5 < KfSecretMaze
			def initialize
				super()
				@wside = Pathway.new("west")
				@nside = Pathway.new("north")
				@sside = Pathway.new("south")
			end
		end

		class Kf_sm_6 < KfSecretMaze
			def initialize
				super()
				@nside = Pathway.new("north")
				@inventory = [
					Zorkda::Actors::Chest.new(
						"large chest", 
						"a large chest sits atop a tree stump", 
						0, 
						[Zorkda::Actors::KokiriSword.new]
					), 
					Zorkda::Actors::Weed.new(nil, nil, 0, "RNG")]
			end
		end

	end
end
