module Zorkda

  module GameFileHandler
    include Zorkda::Db
    include Zorkda::GameFileCookie
    require "json"

    def self.all_params_present?(params)
      params.each do |param|
        return false if !param || param.length.zero?
      end
      return true
    end

    def self.uuid_valid?(uuid)
      entry = Db.get_uuid(uuid)
      return 500 if entry == "read error"
      return false if entry.nil?
      return true
    end

    def self.get_all_game_summaries(uuid)
      return 400 unless self.all_params_present?([uuid])
      valid_uuid = self.uuid_valid?(uuid)
      case valid_uuid
      when "read error"
        return 500
      when false
        return 404
      end
      game_summaries = Zorkda::Db.get_game_summaries(uuid)
      return game_summaries.to_json
    end

    def self.retrieve_game_file(uuid, game_id)
      return 400 unless self.all_params_present?([uuid, game_id])
      response = Zorkda::Db.get_game(uuid, game_id)
      return 500 if response == "read error"
      return 404 if response.nil?
      return response[:game_file]
    end

    def self.initialize_game_file(protagonist_name)
      return 400 unless self.all_params_present?([protagonist_name])
      # TODO: create game file
      # game_file = ...
      game_file = { # temporary
        moves: 0, 
        player_name: protagonist_name, 
        location: {area: "Starting Place", room: "Room 1"}
      }
      return game_file
    end

    def self.output_obj
      return {
        outputLines: [],
        location: {area: nil, room: nil},
        navi: false
      }
    end

    def self.start_game(game_cookie)
      return {loaded: false, gameId: nil} unless Zorkda::GameFileCookie.game_loaded?(game_cookie)
      game_id = Zorkda::GameFileCookie.get_game_id(game_cookie)
      game_file = Zorkda::GameFileCookie.get_game_file(game_cookie)
      # This is temporary, replace with commented out section below
      return {
        loaded: true,
        gameId: game_id,
        outputLines: ["This is game file id #{game_id}", "Your name is #{game_file[:player_name]}", "You are on move #{game_file[:moves].to_i}" ],
        location: game_file[:location], 
        navi: false
      }.to_json
      # output_obj = self.output_obj
      # output_obj[:loaded] = true
      # output_obj[:gameId] = game_id
      # # TODO
      # Zorkda::Engine.run_game(game_file, output_obj)
      # return output_obj.to_json
    end

    def self.input_to_game(game_cookie, input)
      return 400 unless self.all_params_present?([input])
      return 404 unless Zorkda::GameFileCookie.game_loaded?(game_cookie)
      game_file = Zorkda::GameFileCookie.get_game_file(game_cookie)
      # This is temporary, replace with commented out section below
      game_id = Zorkda::GameFileCookie.get_game_id(game_cookie)
      game_file[:moves] = game_file[:moves].to_i + 1
      return {
        outputLines: ["This is game file id #{game_id}", "You are on move #{game_file[:moves]}" ],
        location: game_file[:location],
        navi: true
      }.to_json
      # output_obj = self.output_obj
      # output_obj[:loaded] = true
      # output_obj[:gameId] = game_id
      # # TODO
      # Zorkda::Engine.run_game(game_file, output_obj, input)
      # return output_obj.to_json
    end

    def self.save(game_cookie, uuid, game_id)
      return 400 unless self.all_params_present?([uuid, game_id])
      valid_uuid = self.uuid_valid?(uuid)
      case valid_uuid
      when "read error"
        return 500
      when false
        return 404
      end
      game_file = Zorkda::GameFileCookie.get_game_file(game_cookie)
      game_info = {
        uuid: uuid,
        game_id: game_id,
        game_file: game_file,
        game_summary: self.generate_game_summary(game_id, game_file)
      }
      response = Zorkda::Db.update_game(game_info)
      return 500 if response == "write error"
      return {gameId: game_id}
    end

    def self.save_new(game_cookie, uuid)
      return 400 unless self.all_params_present?([uuid])
      valid_uuid = self.uuid_valid?(uuid)
      case valid_uuid
      when "read error"
        return 500
      when false
        return 404
      end
      game_file = Zorkda::GameFileCookie.get_game_file(game_cookie)
      loop do
        game_id = SecureRandom.hex
        game_info = {
          uuid: uuid,
          game_id: game_id,
          game_file: game_file,
          game_summary: self.generate_game_summary(game_id, game_file)
        }
        response = Zorkda::Db.add_game(game_info)
        next if response == "taken"
        return 500 if response == "write error"
        return {gameId: game_id}
      end
    end

    def self.generate_game_summary(game_id, game_file)
      # TODO: refactor once the real game_file has been created
      return { 
        protagonistName: game_file[:player_name], #TODO 
        location: game_file[:location], #TODO
        id: game_id, 
        saveTimestamp: Time.now.to_i * 1000
      }
    end
    
  end

end