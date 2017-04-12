module Zorkda
  module GameSessionHandler

    def self.get_game_session_file(game_session_id)
      redis_game_file = Zorkda::Cache.get_game_session_file(game_session_id)
      return redis_game_file if redis_game_file && redis_game_file != "read error"
      # return "failed" if redis_game_file == "read error" # temp
      # return nil # temp
      dynamo_response = Zorkda::Db.get_game_session(game_session_id)
      return "failed" if dynamo_response == "read error"
      return dynamo_response[:game_file]
    end

    def self.create_game_session(game_file, game_file_in_bytes = false)
      game_session_id = SecureRandom.uuid
      return self.update_game_session(game_session_id, game_file, game_file_in_bytes, true)
    end

    def self.update_game_session(game_session_id, game_file, game_file_in_bytes = false, save_to_db = false)
      game_file_str = game_file_in_bytes ? 
        Zorkda::ObjectEncoder.bytes_to_str(game_file) : 
        Zorkda::ObjectEncoder.obj_to_str(game_file)

      redis_response = Zorkda::Cache.add_game_session(
        game_session_id, 
        game_file_str, 
        self.cache_session_expiration_time,
        self.game_session_expiration_time
      )
      return "failed" if redis_response == "write error"

      if save_to_db
        game_file_bytes = game_file_in_bytes ? 
          game_file : 
          Zorkda::ObjectEncoder.str_to_bytes(game_file_str)
        dynamo_game_info = {
          game_session_id: game_session_id,
          game_file: game_file_bytes,
          expire_at: self.game_session_expiration_time
        }
        dynamo_response = Zorkda::Db.add_game_session(dynamo_game_info)
        return "failed" if dynamo_response == "write error"
      end
      return game_session_id
    end 

    def self.game_session_expiration_time
      # unix time of when the item will expire
      hours_to_expire = 18
      seconds_to_expire = hours_to_expire * 60 * 60
      return Time.now.to_i + seconds_to_expire
    end

    def self.cache_session_expiration_time
      # unix time of when the item will expire
      hours_to_expire = 3
      seconds_to_expire = hours_to_expire * 60 * 60
      return Time.now.to_i + seconds_to_expire
    end

    def self.transfer_from_cache_to_db(game_session_id)
      game_file_str = nil
      5.times do
        game_file_str = Zorkda::Cache.get_encoded_game_session_file(game_session_id)
        break if game_file_str != "read error"
        sleep(1)
      end
      if !game_file_str || game_file_str == "read error"
        # puts "no game file available" if !game_file_str
        # puts "error while reading from redis" if game_file_str == "read error"
        return "transfer error"
      end
      dynamo_game_info = {
        game_session_id: game_session_id,
        game_file: Zorkda::ObjectEncoder.str_to_bytes(game_file_str),
        expire_at: self.game_session_expiration_time
      }
      dynamo_response = nil
      5.times do
        dynamo_response = Zorkda::Db.add_game_session(dynamo_game_info)
        break if dynamo_response != "write error"
        sleep(1)
      end
      return dynamo_response

    end

  end
end