module Zorkda
	module Actors

    #DONE
		class Boulder < TerrainItem
			
			@@weights = {"brown" => 3, "silver" => 4, "bronze" => 5}
			@@breakables = {"brown" => true, "silver" => false, "bronze" => false}
			@@poss_effective_items = {"brown" => ["bomb", "hammer"], "silver" => nil, "bronze" => nil}

			attr_accessor :drop_name_if_picked_up
			
			def initialize(color, description, distance, contents, respawn)
				super("#{color} boulder", description, distance)
				if contents.is_a?(String) && contents.upcase == "RNG"
					@random_contents = true
					@contents = nil
				else
					@contents = contents
				end
				@weight = @@weights[color]
				@breakable = @@breakables[color]
				@gen_singular = "boulder"
				@gen_plural = "boulders"
				@effective_items = @@poss_effective_items[color]
				@respawn = respawn
				@drop_name_if_picked_up = true
			end
		end

	end
end