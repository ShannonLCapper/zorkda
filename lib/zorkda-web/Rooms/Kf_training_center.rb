module Zorkda
  module Rooms

    #DONE
    class Kf_training_center < Room

			def initialize
				super()
				@name = "Training Center"
				@description = "Around you stands various training supplies."
				@location = "Kokiri Forest"
				@sside = Crawlway.new("south")
				@nside = Pathway.new("north")
				@eside.change_type(:wooden_fence)
				@wside.change_type(:trees)
				@inventory = [
					Zorkda::Actors::Grass.new(nil, nil, 0, "RNG"), 
					Zorkda::Actors::Grass.new(nil, nil, 0, "RNG"), 
					Zorkda::Actors::Rock.new(nil, nil, 0, "RNG"), 
					Zorkda::Actors::Rock.new(nil, nil, 0, "RNG"), 
					Zorkda::Actors::Rock.new(nil, nil, 0, "RNG")
				]
				@characters = [
					Zorkda::Actors::KfTrainingCenterKokiri.new
				]
			end

		end

	end
end