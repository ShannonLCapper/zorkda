module Zorkda
	module Actors

		class Thing
			attr_accessor :name, :description, :distance, :original_distance, :visible,
			:weight, :respawn, :respawn_while_in_room, :can_pick_up, :drop_name_if_picked_up, 
			:can_slide, :cuttable, :breakable, :flammable, :hookshotable, :can_roll_into, 
			:hittable, :respawn_time, :moves_when_removed, :parent_alias, :effective_items,
			:openable, :can_hit_things, :can_cut_things, :submerged, :submerged_distance,
			:stunned_by, :on_fire, :has_parenthetical_name, :parenthetical_name, :can_step_on,
			:display, :random_contents

			def initialize
				@name = nil
				@description = nil
				@display = true
				@distance = 0
				@original_distance = nil
				@visible = true
				@weight = 0
				@respawn = false
				@can_pick_up = false
				@drop_name_if_picked_up = false
				@can_slide = false
				@cuttable = false
				@breakable = false
				@flammable = false
				@on_fire = false
				@hittable = false
				@hookshotable = false
				@can_roll_into = false
				@respawn_time = 1.0/0.0
				@moves_when_removed = nil
				@respawn_while_in_room = false
				@parent_alias = false
				@effective_items = []
				@openable = false
				@can_hit_things = false
				@can_cut_things = false
				@submerged = false
				@submerged_distance = 1
				@stunned_by = []
				@parenthetical_name = nil
				@can_step_on = false
				@random_contents = false
			end

			def set_distance(distance)
				self.original_distance = distance
				self.distance = distance
			end

			def hit_with_bomb(game_status, damage)
				return false
			end
		end

	end
end