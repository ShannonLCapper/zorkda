Dir[File.dirname(__FILE__) + '/Actions/*.rb'].each {|file| require file }
require_relative 'Enter_and_respawn_room'
require_relative 'Parser_utilities'
require_relative 'Help_dialogue'

def parser_old(game_status)

	player = game_status.player
	curr_room = game_status.curr_room
	navi = game_status.navi
	move_counter = game_status.move_counter
	checkpoint = game_status.checkpoint
	
	1.times do

		response = prompt.downcase.split(" ")

		if response[0] == "my"
			response.delete_at(0)
		end
		
		#utility commands
		if response == ["help"] || response == ["halp"] || response == ["help", "me"]
			print_help_dialogue
			redo
		elsif response == ["heart", "pieces"]
			player.display_heart_pieces
			redo
		elsif response == ["carrying"] || (response[0..2] == ["what", "am", "i"] && 
		(response[3] == "carrying?" || response[3] == "holding?" || response[3] == "carrying" || response[3] == "holding"))
			player.display_carrying
			redo
		elsif response == ["enemy", "info"]
			navi.give_enemy_info(curr_room.enemies)
			redo
		elsif response == ["navi"] || response == ["talk", "to", "navi"]
			if curr_room.navi_hint != nil
				navi.give_hint(curr_room.navi_hint)
			else
				navi.give_directive(checkpoint)
			end
			redo
		elsif response == ["verbose"]
			if game_status.brief == true
				puts "Long descriptions for each room are now restored"
				game_status.brief = false
			else
				puts "You are already in verbose mode."
			end
			redo
		elsif response == ["brief"]
			if game_status.brief == false
				puts "Long descriptions for rooms you have already been to will not be shown."
				game_status.brief = true
			else
				puts "You are already in brief mode."
			end
			redo
		elsif response == ["look"] || response == ["l"] || response == ["look", "around"]
			describe_room(curr_room)
			redo
		elsif response == ["inventory"] || response == ["i"]
			player.display_inventory
			redo
		elsif response == ["health"] || response == ["hearts"] || response == ["h"] || response == ["health", "meter"]
			player.display_health
			redo
		elsif response == ["wallet"] || response == ["rupees"] || response == ["money"] || response == ["r"]
			player.display_wallet
			redo
		elsif response == ["equipment"] || response == ["e"]
			player.display_equipment
			redo
		elsif response == ["tokens"] || response == ["gold", "skulltula", "tokens"]
			player.display_tokens
			redo
		elsif response == ["medallions"]
			player.display_medallions
			redo
		elsif response == ["stones"] || response == ["spiritual", "stones"]
			player.display_stones
			redo
		elsif response == ["save"]
			save(game_status)
			redo
		elsif response == ["quit"]
			quit
			redo
		elsif response == ["save", "and", "quit"]
			save(game_status)
			quit
			redo
		elsif response == ["next"] || response == ["n"] || response == ["wait"]
		
		#go
		elsif response[0] == "walk" || response[0] == "run" || response[0] == "climb" || response[0] == "crawl" || response[0] == "swim"
			puts "Try using the action \"go <direction>\" instead."
		elsif action_one_obj("go", method(:go), game_status, response)
	
		# pick up/get
		elsif action_one_obj("pick up", method(:pick_up), game_status, response)
		elsif action_one_obj("get", method(:pick_up), game_status, response)

		#extinguish
		elsif action_one_obj("extinguish", method(:extinguish), game_status, response)

		#put down/drop
		elsif action_one_or_two_objs("put down", "on", method(:drop), game_status, response)
		elsif action_one_or_two_objs("drop", "on", method(:drop), game_status, response)

		#step on/press
		elsif action_one_obj("step on", method(:step_on), game_status, response) 
		elsif action_one_obj("press", method(:step_on), game_status, response)
		
		#slide/push
		elsif action_one_obj("push", method(:push), game_status, response)
		elsif action_one_obj("slide", method(:push), game_status, response)

		#buy
		elsif action_one_obj_dont_allow_certain_words("buy", method(:buy), ["from"], game_status, response)

		#talk to/speak to
		elsif action_one_obj("talk to", method(:talk_to), game_status, response)
		elsif action_one_obj("speak to", method(:talk_to), game_status, response)

		#block
		elsif action_no_obj("block", method(:block), game_status, response)

		#dodge
		elsif action_no_obj("dodge", method(:dodge), game_status, response)

		#roll
		elsif action_one_obj("roll into", method(:roll_into), game_status, response)

		#throw
		elsif action_one_or_two_objs("throw", "at", method(:throw), game_status, response)
		elsif action_one_or_two_objs("toss", "at", method(:throw), game_status, response)
		elsif action_one_or_two_objs("chuck", "at", method(:throw), game_status, response)	

		#open
		elsif action_one_obj_dont_allow_certain_words("open", method(:open_obj), ["with"], game_status, response)

		#hit
		elsif action_two_objs("hit", "with", method(:hit), game_status, response)

		#shoot
		elsif action_two_objs_opposite_splitter_words("shoot", ["with", "at"], method(:shoot), game_status, response)
		
		#break
		elsif action_two_objs("break", "with", method(:break), game_status, response)

		#cut
		elsif action_one_or_two_objs("cut", "with", method(:cut), game_status, response)

		#light
		elsif action_two_objs("light", "with", method(:light), game_status, response)

		#play
		elsif action_one_obj_dont_allow_certain_words("play", method(:play), ["with", "on"], game_status, response)

		#unlock
		elsif action_one_obj_dont_allow_certain_words("unlock", method(:unlock), ["with"], game_status, response)

		#equip
		elsif response[0] == "deequip" || response[0] == "unequip" || response[0..1] == ["take", "off"]
			puts "Type \"equip <different item>\" to equip something else."
			redo
		elsif action_one_obj("equip", method(:equip), game_status, response)
			redo
		#dive_for
		elsif action_one_obj("dive for", method(:dive_for), game_status, response)

		elsif response == ["enter", "portal"]
			enter_portal(game_status)

		else
			puts "I don't know that command."
			redo
		end
	end
end