module Zorkda
	module Parser

		#DONE
		def self.parse(game_status, input)

			player = game_status.player
			curr_room = game_status.curr_room
			navi = game_status.navi
			move_counter = game_status.move_counter
			checkpoint = game_status.checkpoint

			response = input.downcase.split(" ")

			if response[0] == "my"
				response.delete_at(0)
			end
			
			#utility commands
			case response
			# when ["help"], ["halp"], ["help", "me"]
			# 	self::Utils.print_help_dialogue
			# 	game_status.move_counter -= 1
			when ["heart", "pieces"]
				player.display_heart_pieces
				game_status.move_counter -= 1
			when ["carrying"], ["what", "am", "i", "holding?"], ["what", "am", "i", "holding"], ["what", "am", "i", "carrying?"], ["what", "am", "i", "carrying"]
				player.display_carrying
				game_status.move_counter -= 1
			when ["enemy", "info"]
				navi.give_enemy_info(curr_room.enemies)
				game_status.move_counter -= 1
			when ["navi"], ["talk", "to", "navi"]
				if curr_room.navi_hint != nil
					navi.give_hint(curr_room.navi_hint)
				else
					navi.give_directive(checkpoint)
				end
				game_status.move_counter -= 1
			when ["verbose"]
				if game_status.brief == true
					Zorkda::GameOutput.add_line("Long descriptions for each room are now restored")
					game_status.brief = false
				else
					Zorkda::GameOutput.add_line("You are already in verbose mode.")
				end
				game_status.move_counter -= 1
			when ["brief"]
				if game_status.brief == false
					Zorkda::GameOutput.add_line("Long descriptions for rooms you have already been to will not be shown.")
					game_status.brief = true
				else
					Zorkda::GameOutput.add_line("You are already in brief mode.")
				end
				game_status.move_counter -= 1
			when ["look"], ["l"], ["look", "around"]
				Zorkda::Engine.describe_room(curr_room)
				game_status.move_counter -= 1
			when ["inventory"], ["i"]
				player.display_inventory
				game_status.move_counter -= 1
			when ["health"], ["hearts"], ["h"], ["health", "meter"]
				player.display_health
				game_status.move_counter -= 1
			when ["wallet"], ["rupees"], ["money"], ["r"]
				player.display_wallet
				game_status.move_counter -= 1
			when ["equipment"], ["e"]
				player.display_equipment
				game_status.move_counter -= 1
			when ["tokens"], ["gold", "skulltula", "tokens"]
				player.display_tokens
				game_status.move_counter -= 1
			when ["medallions"]
				player.display_medallions
				game_status.move_counter -= 1
			when ["stones"], ["spiritual", "stones"]
				player.display_stones
				game_status.move_counter -= 1
			when ["next"], ["n"], ["wait"]
			#actions
			when ["enter", "portal"]
				Zorkda::Actions.enter_portal(game_status)
			else
				case response[0]
				when "walk", "run", "climb", "crawl", "swim"
					Zorkda::GameOutput.add_line("Try using the action &quot;go &lt;direction&gt;&quot; instead.")
					game_status.move_counter -= 1
					return
				else
				end

				#go
				if self::Utils.action_one_obj("go", Zorkda::Actions.method(:go), game_status, response)
			
				# pick up/get
				elsif self::Utils.action_one_obj("pick up", Zorkda::Actions.method(:pick_up), game_status, response)
				elsif self::Utils.action_one_obj("get", Zorkda::Actions.method(:pick_up), game_status, response)

				#extinguish
				elsif self::Utils.action_one_obj("extinguish", Zorkda::Actions.method(:extinguish), game_status, response)

				#put down/drop
				elsif self::Utils.action_one_or_two_objs("put down", "on", Zorkda::Actions.method(:drop), game_status, response)
				elsif self::Utils.action_one_or_two_objs("drop", "on", Zorkda::Actions.method(:drop), game_status, response)

				#step on/press
				elsif self::Utils.action_one_obj("step on", Zorkda::Actions.method(:step_on), game_status, response) 
				elsif self::Utils.action_one_obj("press", Zorkda::Actions.method(:step_on), game_status, response)
				
				#slide/push
				elsif self::Utils.action_one_obj("push", Zorkda::Actions.method(:push), game_status, response)
				elsif self::Utils.action_one_obj("slide", Zorkda::Actions.method(:push), game_status, response)

				#buy
				elsif self::Utils.action_one_obj_dont_allow_certain_words("buy", Zorkda::Actions.method(:buy), ["from"], game_status, response)

				#talk to/speak to
				elsif self::Utils.action_one_obj("talk to", Zorkda::Actions.method(:talk_to), game_status, response)
				elsif self::Utils.action_one_obj("speak to", Zorkda::Actions.method(:talk_to), game_status, response)

				#block
				elsif self::Utils.action_no_obj("block", Zorkda::Actions.method(:block), game_status, response)

				#dodge
				elsif self::Utils.action_no_obj("dodge", Zorkda::Actions.method(:dodge), game_status, response)

				#roll
				elsif self::Utils.action_one_obj("roll into", Zorkda::Actions.method(:roll_into), game_status, response)

				#throw
				elsif self::Utils.action_one_or_two_objs("throw", "at", Zorkda::Actions.method(:throw_obj), game_status, response)
				elsif self::Utils.action_one_or_two_objs("toss", "at", Zorkda::Actions.method(:throw_obj), game_status, response)
				elsif self::Utils.action_one_or_two_objs("chuck", "at", Zorkda::Actions.method(:throw_obj), game_status, response)	

				#open
				elsif self::Utils.action_one_obj_dont_allow_certain_words("open", Zorkda::Actions.method(:open_obj), ["with"], game_status, response)

				#hit
				elsif self::Utils.action_two_objs("hit", "with", Zorkda::Actions.method(:hit), game_status, response)

				#shoot
				elsif self::Utils.action_two_objs_opposite_splitter_words("shoot", ["with", "at"], Zorkda::Actions.method(:shoot), game_status, response)
				
				#break
				elsif self::Utils.action_two_objs("break", "with", Zorkda::Actions.method(:break), game_status, response)

				#cut
				elsif self::Utils.action_one_or_two_objs("cut", "with", Zorkda::Actions.method(:cut), game_status, response)

				#light
				elsif self::Utils.action_two_objs("light", "with", Zorkda::Actions.method(:light), game_status, response)

				# #play
				# elsif self::Utils.action_one_obj_dont_allow_certain_words("play", Zorkda::Actions.method(:play), ["with", "on"], game_status, response)

				# #unlock
				# elsif self::Utils.action_one_obj_dont_allow_certain_words("unlock", Zorkda::Actions.method(:unlock), ["with"], game_status, response)

				#equip
				elsif response[0] == "deequip" || response[0] == "unequip" || response[0..1] == ["take", "off"]
					Zorkda::GameOutput.add_line("Type &quot;equip &lt;different item&gt;&quot; to equip something else.")
					game_status.move_counter -= 1
				elsif self::Utils.action_one_obj("equip", Zorkda::Actions.method(:equip), game_status, response)
					game_status.move_counter -= 1
				#dive_for
				elsif self::Utils.action_one_obj("dive for", Zorkda::Actions.method(:dive_for), game_status, response)

				else
					Zorkda::GameOutput.add_line("I don't know that command.")
					game_status.move_counter -= 1
				end
			end
		end

	end
end