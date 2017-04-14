module Zorkda
  module GameFileHandler

    require "json"

    def self.all_params_present?(params)
      params.each do |param|
        return false if !param || param.length.zero?
      end
      return true
    end

    def self.uuid_exists?(uuid)
      entry = Zorkda::Db.get_uuid(uuid)
      return 500 if entry == "read error"
      return false if entry.nil?
      return true
    end

    def self.get_all_game_summaries(uuid)
      return 400 unless self.all_params_present?([uuid])
      valid_uuid = self.uuid_exists?(uuid)
      case valid_uuid
      when "read error"
        return 500
      when false
        return 404
      end
      game_summaries = Zorkda::Db.get_game_summaries(uuid)
      return game_summaries.to_json
    end

    def self.load_game_file(uuid, saved_game_id)
      return 400 unless self.all_params_present?([uuid, saved_game_id])
      response = Zorkda::Db.get_saved_game(uuid, saved_game_id, false)
      return 500 if response == "read error"
      return 404 if response.nil?
      game_session_id = Zorkda::GameSessionHandler.create_game_session(response["game_file"], true)
      # return status code if adding game file to game sessions failed
      return 500 if game_session_id == "failed"
      return {
        gameSessionId: game_session_id,
        savedGameId: saved_game_id
      }.to_json
    end

    def self.load_new_game_file(protagonist_name)
      return 400 unless self.all_params_present?([protagonist_name])
      game_file = Zorkda::Engine.initialize_new_game(protagonist_name)
      game_session_id = Zorkda::GameSessionHandler.create_game_session(game_file)
      # return status code if adding game file to game sessions failed
      return 500 if game_session_id == "failed"
      return { gameSessionId: game_session_id }.to_json
    end

    def self.start_game(game_session_id)
      return 400 unless self.all_params_present?([game_session_id])
      game_file = Zorkda::GameSessionHandler.get_game_session_file(game_session_id)
      return 500 if game_file == "failed"
      return 404 if game_file.nil?
      begin
        game_output = Zorkda::Engine.run_game(game_file)
      rescue Exception => e
        puts e.message
        puts e.backtrace.join("\n")
        return 500
      end
      update_game_session_response = Zorkda::GameSessionHandler.update_game_session(game_session_id, game_file)
      return 500 if update_game_session_response == "failed"
      # return { # temporary
      #   outputLines: ["Your name is #{game_file.player.name}", "You are on move #{game_file.move_counter.to_i}" ],
      #   location: game_file.get_location, 
      #   navi: false
      # }.to_json
      return game_output.to_json
    end

    def self.input_to_game(game_session_id, input)
      return 404 unless self.all_params_present?([game_session_id])
      return 400 unless self.all_params_present?([input])
      game_file = Zorkda::GameSessionHandler.get_game_session_file(game_session_id)
      return 500 if game_file == "failed"
      return 404 if game_file.nil?
      begin
        game_output = Zorkda::Engine.run_game(game_file, input)
      rescue Excpetion => e
        puts e.message
        puts e.backtrace.join("\n")
        return 500
      end
      # game_file.move_counter += 1 #temporary
      update_game_session_response = Zorkda::GameSessionHandler.update_game_session(game_session_id, game_file)
      return 500 if update_game_session_response == "failed"
      # return { # temporary
      #   outputLines: ["You are on move #{game_file.move_counter.to_i}" ],
      #   location: game_file.get_location,
      #   navi: true
      # }.to_json
      return game_output.to_json
    end

    def self.save(game_session_id, uuid, save_game_id)
      return 400 unless self.all_params_present?([uuid, save_game_id])
      return 404 unless self.all_params_present?([game_session_id])
      game_file = Zorkda::GameSessionHandler.get_game_session_file(game_session_id)
      return 500 if game_file == "failed"
      return 404 if game_file.nil?
      game_info = {
        uuid: uuid,
        game_id: save_game_id,
        game_file: Zorkda::ObjectEncoder.obj_to_bytes(game_file)
      }
      response = Zorkda::Db.add_saved_game(game_info)
      return 500 if response == "write error"
      game_summary_info = {
        uuid: uuid,
        game_id: save_game_id,
        game_summary: self.generate_game_summary(save_game_id, game_file)
      }
      Zorkda::Db.put_game_summary(game_summary_info)
      return {savedGameId: save_game_id}.to_json
    end

    def self.save_new(game_session_id, uuid)
      save_game_id = SecureRandom.hex
      return self.save(game_session_id, uuid, save_game_id)
      ##no longer needed
      # return 400 unless self.all_params_present?([uuid])
      # return 404 unless self.all_params_present?([game_session_id])
      # game_file = Zorkda::GameSessionHandler.get_game_session_file(game_session_id)
      # loop do
      #   save_game_id = SecureRandom.hex
      #   game_info = {
      #     uuid: uuid,
      #     game_id: save_game_id,
      #     game_file: Zorkda::ObjectEncoder.obj_to_bytes(game_file)
      #   }
      #   response = Zorkda::Db.add_saved_game(game_info)
      #   next if response == "taken"
      #   return 500 if response == "write error"
      #   game_summary_info = {
      #     uuid: uuid,
      #     game_id: save_game_id,
      #     game_summary: self.generate_game_summary(save_game_id, game_file)
      #   }
      #   Zorkda::Db.put_game_summary(game_summary_info)
      #   return {savedGameId: save_game_id}.to_json
      # end
    end

    def self.generate_game_summary(save_game_id, game_file)
      return { 
        protagonistName: game_file.player.name,
        location: game_file.get_location,
        health: game_file.player.display_health,
        id: save_game_id, 
        saveTimestamp: Time.now.to_i * 1000
      }
    end
    
  end
end