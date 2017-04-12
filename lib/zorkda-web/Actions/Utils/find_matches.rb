module Zorkda
	module Actions
		module Utils

			#DONE
			def self.find_matches_search_all(curr_room, typed_obj)
				matches = find_matches(curr_room.inventory, typed_obj)
				if matches.length == 0
					matches = find_matches(curr_room.enemies, typed_obj)
				end
				if matches.length == 0
					matches = find_matches(curr_room.characters, typed_obj)
				end
				return matches
			end

			def self.find_matches(possibilities, typed_obj)
				matches = []
				if possibilities == nil
					return matches
				end
				possibilities.each do |item|
					if typed_obj == item.name.downcase || typed_obj == item.gen_plural.downcase || typed_obj == item.gen_singular.downcase
						matches << item
					elsif item.parent_alias && (typed_obj == item.parent_singular.downcase || typed_obj == item.parent_plural.downcase)
							matches << item
					elsif item.instance_variable_defined?(:@race)
						if typed_obj == item.race_singular.downcase || typed_obj == item.race_plural.downcase
							matches << item
						end
					end
				end
				return matches
			end

			def self.find_matches_search_all_id_parent(curr_room, typed_obj)
				matches, matched_parent, parent_singular, parent_plural = find_matches_id_parent(curr_room.inventory, typed_obj)
				if matches.length == 0
					matches, matched_parent, parent_singular, parent_plural = find_matches_id_parent(curr_room.enemies, typed_obj)
				end
				if matches.length == 0
					matches, matched_parent, parent_singular, parent_plural = find_matches_id_parent(curr_room.characters, typed_obj)
				end
				return matches, matched_parent, parent_singular, parent_plural
			end

			def self.find_matches_id_parent(possibilities, typed_obj)
				matches = []
				matched_parent = false
				parent_singular = ""
				parent_plural = ""
				if possibilities == nil
					return matches
				end
				possibilities.each do |item|
					if typed_obj == item.name.downcase || typed_obj == item.gen_plural.downcase || typed_obj == item.gen_singular.downcase
						matches << item
					elsif item.parent_alias && (typed_obj == item.parent_singular.downcase || typed_obj == item.parent_plural.downcase)
							matches << item
							matched_parent = true
							parent_singular = item.parent_singular.downcase
							parent_plural = item.parent_plural.downcase
					elsif item.instance_variable_defined?(:@race)
						if typed_obj == item.race_singular.downcase || typed_obj == item.race_plural.downcase
							matches << item
						end
					end
				end
				return matches, matched_parent, parent_singular, parent_plural
			end

		end
	end
end

