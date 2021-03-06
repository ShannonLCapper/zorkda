module Zorkda
	module Engine

		#DONE
		def self.initialize_new_game(protagonist_name)
			#create Link
			player = Zorkda::Actors::Protagonist.new(protagonist_name)

			#create rooms
			child_rooms = {
				#test rooms
				:test_1 => Zorkda::Rooms::Test_room_1.new,
				:test_2 => Zorkda::Rooms::Test_room_2.new,
				:test_3 => Zorkda::Rooms::Test_room_3.new,

				#Kokiri Forest
				:links_house => Zorkda::Rooms::Links_house.new,
				:links_balcony => Zorkda::Rooms::Links_balcony.new,
				:kf_s => Zorkda::Rooms::Kf_s.new,
				:kf_se => Zorkda::Rooms::Kf_se.new,
				:kf_sw => Zorkda::Rooms::Kf_sw.new,
				:kf_central => Zorkda::Rooms::Kf_central.new,
				:kf_e => Zorkda::Rooms::Kf_e.new,
				:kf_w => Zorkda::Rooms::Kf_w.new,
				:kf_ne => Zorkda::Rooms::Kf_ne.new,
				:kf_n => Zorkda::Rooms::Kf_n.new,
				:kf_nw => Zorkda::Rooms::Kf_nw.new,
				:kf_training_center => Zorkda::Rooms::Kf_training_center.new,
				:kf_sm_1 => Zorkda::Rooms::Kf_sm_1.new,
				:kf_sm_2 => Zorkda::Rooms::Kf_sm_2.new,
				:kf_sm_3 => Zorkda::Rooms::Kf_sm_3.new,
				:kf_sm_4 => Zorkda::Rooms::Kf_sm_4.new,
				:kf_sm_5 => Zorkda::Rooms::Kf_sm_5.new,
				:kf_sm_6 => Zorkda::Rooms::Kf_sm_6.new,
				:sarias_house => Zorkda::Rooms::Sarias_house.new,
				:twins_house => Zorkda::Rooms::Twins_house.new,
				:know_it_all_house => Zorkda::Rooms::Know_it_all_house.new,
				:midos_house => Zorkda::Rooms::Midos_house.new,
				:kf_shop => Zorkda::Rooms::Kf_shop.new,
				:kf_narrow_path => Zorkda::Rooms::Kf_narrow_path.new,
				:kf_deku_glen => Zorkda::Rooms::Kf_deku_glen.new,

				#inside the deku tree
				:idt_f1_main => Zorkda::Rooms::Idt_f1_main.new,
				:idt_f2_main => Zorkda::Rooms::Idt_f2_main.new,
				:idt_f2_2 => Zorkda::Rooms::Idt_f2_2.new,
				:idt_f2_3 => Zorkda::Rooms::Idt_f2_3.new,
				:idt_f3_landing => Zorkda::Rooms::Idt_f3_landing.new,
				:idt_f3_main => Zorkda::Rooms::Idt_f3_main.new,
				:idt_f3_2 => Zorkda::Rooms::Idt_f3_2.new,
				:idt_f3_cubby => Zorkda::Rooms::Idt_f3_cubby.new,
				:idt_b1_sewer_east => Zorkda::Rooms::Idt_b1_sewer_east.new,
				:idt_b1_2 => Zorkda::Rooms::Idt_b1_2.new,
				:idt_b1_3_east => Zorkda::Rooms::Idt_b1_3_east.new,
				:idt_b1_3_west => Zorkda::Rooms::Idt_b1_3_west.new,
				:idt_b1_4 => Zorkda::Rooms::Idt_b1_4.new,
				:idt_b1_5 => Zorkda::Rooms::Idt_b1_5.new,
				:idt_b1_sewer_west => Zorkda::Rooms::Idt_b1_sewer_west.new,
				:idt_b2_antechamber => Zorkda::Rooms::Idt_b2_antechamber.new,
				:idt_gohmas_lair => Zorkda::Rooms::Idt_gohmas_lair.new

			}

			#connect rooms

			#test rooms
			child_rooms[:test_1].nside.goes_to = child_rooms[:test_2]
			child_rooms[:test_1].wside.goes_to = child_rooms[:test_3]
			child_rooms[:test_2].sside.goes_to = child_rooms[:test_1]
			child_rooms[:test_3].eside.goes_to = child_rooms[:test_1]

			#Kokiri Forest
			child_rooms[:links_house].nside.goes_to = child_rooms[:links_balcony]
			child_rooms[:links_balcony].sside.goes_to = child_rooms[:links_house]
			child_rooms[:links_balcony].dside.goes_to = child_rooms[:kf_s]
			child_rooms[:kf_s].uside.goes_to = child_rooms[:links_balcony]
			child_rooms[:kf_s].nside.goes_to = child_rooms[:kf_central]
			child_rooms[:kf_s].wside.goes_to = child_rooms[:kf_sw]
			child_rooms[:kf_s].eside.goes_to = child_rooms[:kf_se]
			child_rooms[:kf_sw].nside.goes_to = child_rooms[:kf_w]
			child_rooms[:kf_sw].wside.goes_to = child_rooms[:know_it_all_house]
			child_rooms[:kf_sw].sside.goes_to = child_rooms[:kf_training_center]
			child_rooms[:kf_sw].eside.goes_to = child_rooms[:kf_s]
			child_rooms[:kf_se].nside.goes_to = child_rooms[:kf_e]
			child_rooms[:kf_se].wside.goes_to = child_rooms[:kf_s]
			child_rooms[:kf_se].eside.goes_to = child_rooms[:twins_house]
			child_rooms[:kf_se].sside.goes_to = child_rooms[:sarias_house]
			child_rooms[:kf_w].nside.goes_to = child_rooms[:kf_nw]
			child_rooms[:kf_w].eside.goes_to = child_rooms[:kf_central]
			child_rooms[:kf_w].sside.goes_to = child_rooms[:kf_sw]
			#needs connection of kf_w to bridge
			child_rooms[:kf_central].nside.goes_to = child_rooms[:kf_n]
			child_rooms[:kf_central].wside.goes_to = child_rooms[:kf_w]
			child_rooms[:kf_central].eside.goes_to = child_rooms[:kf_e]
			child_rooms[:kf_central].sside.goes_to = child_rooms[:kf_s]
			child_rooms[:kf_e].nside.goes_to = child_rooms[:kf_ne]
			child_rooms[:kf_e].wside.goes_to = child_rooms[:kf_central]
			child_rooms[:kf_e].eside.goes_to = child_rooms[:kf_narrow_path]
			child_rooms[:kf_e].sside.goes_to = child_rooms[:kf_se]
			child_rooms[:kf_e].nside.goes_to = child_rooms[:kf_ne]
			child_rooms[:kf_nw].nside.goes_to = child_rooms[:midos_house]
			child_rooms[:kf_nw].eside.goes_to = child_rooms[:kf_n]
			child_rooms[:kf_nw].sside.goes_to = child_rooms[:kf_w]
			#needs connection of kf_n to Lost Woods
			child_rooms[:kf_n].sside.goes_to = child_rooms[:kf_central]
			child_rooms[:kf_n].eside.goes_to = child_rooms[:kf_ne]
			child_rooms[:kf_n].wside.goes_to = child_rooms[:kf_nw]
			child_rooms[:kf_ne].nside.goes_to = child_rooms[:kf_shop]
			child_rooms[:kf_ne].wside.goes_to = child_rooms[:kf_n]
			child_rooms[:kf_ne].sside.goes_to = child_rooms[:kf_e]
			child_rooms[:kf_narrow_path].wside.goes_to = child_rooms[:kf_e]
			child_rooms[:kf_narrow_path].eside.goes_to = child_rooms[:kf_deku_glen]
			child_rooms[:kf_deku_glen].wside.goes_to = child_rooms[:kf_narrow_path]
			child_rooms[:midos_house].sside.goes_to = child_rooms[:kf_nw]
			child_rooms[:kf_shop].sside.goes_to = child_rooms[:kf_ne]
			child_rooms[:twins_house].wside.goes_to = child_rooms[:kf_se]
			child_rooms[:sarias_house].nside.goes_to = child_rooms[:kf_se]
			child_rooms[:know_it_all_house].eside.goes_to = child_rooms[:kf_sw]
			child_rooms[:kf_training_center].nside.goes_to = child_rooms[:kf_sw]
			child_rooms[:kf_training_center].sside.goes_to = child_rooms[:kf_sm_1]
			child_rooms[:kf_sm_1].nside.goes_to = child_rooms[:kf_training_center]
			child_rooms[:kf_sm_1].eside.goes_to = child_rooms[:kf_sm_2]
			child_rooms[:kf_sm_2].wside.goes_to = child_rooms[:kf_sm_1]
			child_rooms[:kf_sm_2].eside.goes_to = child_rooms[:kf_sm_3]
			child_rooms[:kf_sm_2].sside.goes_to = child_rooms[:kf_sm_4]
			child_rooms[:kf_sm_3].wside.goes_to = child_rooms[:kf_sm_2]
			child_rooms[:kf_sm_3].sside.goes_to = child_rooms[:kf_sm_5]
			child_rooms[:kf_sm_4].nside.goes_to = child_rooms[:kf_sm_2]
			child_rooms[:kf_sm_4].eside.goes_to = child_rooms[:kf_sm_5]
			child_rooms[:kf_sm_5].wside.goes_to = child_rooms[:kf_sm_4]
			child_rooms[:kf_sm_5].nside.goes_to = child_rooms[:kf_sm_3]
			child_rooms[:kf_sm_5].sside.goes_to = child_rooms[:kf_sm_6]
			child_rooms[:kf_sm_6].nside.goes_to = child_rooms[:kf_sm_5]
			child_rooms[:kf_deku_glen].eside.goes_to = child_rooms[:idt_f1_main]

			#Inside the Deku Tree
			child_rooms[:idt_f1_main].wside.goes_to = child_rooms[:kf_deku_glen]
			child_rooms[:idt_f1_main].uside.goes_to = child_rooms[:idt_f2_main]
			child_rooms[:idt_f2_main].dside.goes_to = child_rooms[:idt_f1_main]
			child_rooms[:idt_f2_main].uside.goes_to = child_rooms[:idt_f3_landing]
			child_rooms[:idt_f2_main].wside.goes_to = child_rooms[:idt_f2_2]
			child_rooms[:idt_f2_2].eside.goes_to = child_rooms[:idt_f2_main]
			child_rooms[:idt_f2_2].wside.goes_to = child_rooms[:idt_f2_3]
			child_rooms[:idt_f2_3].eside.goes_to = child_rooms[:idt_f2_2]
			child_rooms[:idt_f3_landing].wside.goes_to = child_rooms[:idt_f3_main]
			child_rooms[:idt_f3_landing].dside.goes_to = child_rooms[:idt_f2_main]
			child_rooms[:idt_f3_main].eside.goes_to = child_rooms[:idt_f3_landing]
			child_rooms[:idt_f3_main].wside.goes_to = child_rooms[:idt_f3_2]
			child_rooms[:idt_f3_2].eside.goes_to = child_rooms[:idt_f3_main]
			child_rooms[:idt_f3_2].sside.goes_to = child_rooms[:idt_f3_cubby]
			child_rooms[:idt_f3_cubby].nside.goes_to = child_rooms[:idt_f3_2]
			child_rooms[:idt_f3_main].dside.goes_to = child_rooms[:idt_b1_sewer_east]
			child_rooms[:idt_f1_main].dside.goes_to = child_rooms[:idt_b1_sewer_east]
			child_rooms[:idt_b1_sewer_east].uside.goes_to = child_rooms[:idt_f1_main]
			child_rooms[:idt_b1_sewer_east].sside.goes_to = child_rooms[:idt_b1_2]
			child_rooms[:idt_b1_2].nside.goes_to = child_rooms[:idt_b1_sewer_east]
			child_rooms[:idt_b1_2].wside.goes_to = child_rooms[:idt_b1_3_east]
			child_rooms[:idt_b1_3_east].eside.goes_to = child_rooms[:idt_b1_2]
			child_rooms[:idt_b1_3_east].wside.goes_to = child_rooms[:idt_b1_3_west]
			child_rooms[:idt_b1_3_west].eside.goes_to = child_rooms[:idt_b1_3_east]
			child_rooms[:idt_b1_3_west].wside.goes_to = child_rooms[:idt_b1_4]
			child_rooms[:idt_b1_4].eside.goes_to = child_rooms[:idt_b1_3_west]
			child_rooms[:idt_b1_4].nside.goes_to = child_rooms[:idt_b1_5]
			child_rooms[:idt_b1_5].sside.goes_to = child_rooms[:idt_b1_4]
			child_rooms[:idt_b1_5].eside.goes_to = child_rooms[:idt_b1_sewer_west]
			child_rooms[:idt_b1_sewer_west].wside.goes_to = child_rooms[:idt_b1_5]
			child_rooms[:idt_b1_sewer_west].eside.goes_to = child_rooms[:idt_b1_sewer_east]
			child_rooms[:idt_b1_sewer_east].wside.goes_to = child_rooms[:idt_b1_sewer_west]
			child_rooms[:idt_b1_sewer_west].dside.goes_to = child_rooms[:idt_b2_antechamber]
			child_rooms[:idt_b2_antechamber].uside.goes_to = child_rooms[:idt_b1_sewer_west]
			child_rooms[:idt_b2_antechamber].nside.goes_to = child_rooms[:idt_gohmas_lair]

			#set up respawn point for dungeon rooms
			child_rooms.each_value do |room|
				if room.is_a?(Zorkda::Rooms::InsideDekuTree)
					room.respawn_point = child_rooms[:kf_deku_glen]
				end
			end

			#rename Links house
			child_rooms[:links_house].name = "#{player.name}'s House"
			child_rooms[:links_balcony].name = "#{player.name}'s Balcony"
			##################### need to do this for adult rooms too

			return Zorkda::Engine::GameStatus.new(player, child_rooms[:links_house], child_rooms)
		end

	end
end