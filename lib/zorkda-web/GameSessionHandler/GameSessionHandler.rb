module Zorkda

  module GameFileCookie

    def self.get_game_file(game_cookie)
      return game_cookie[:game_file]
    end

    def self.game_loaded?(game_cookie)
      return !game_cookie.nil?
    end

    def self.get_game_id(game_cookie)
      return nil unless self.game_loaded?(game_cookie)
      return game_cookie[:game_id]
    end

  end

  module GameSessionHandler

    def self.get_game_session_file(game_session_id, symbolize_and_decode = true)
      response = Zorkda::Db.get_game_session(game_session_id, symbolize_and_decode)
      return "failed" if response == "read error"
      return response[:game_file] if symbolize_and_decode
      return response["game_file"]
    end

    def self.create_game_session(game_file, encode_game_file = true)
      loop do
        game_session_id = SecureRandom.uuid
        game_info = {
          game_session_id: game_session_id,
          game_file: encode_game_file ? Zorkda::ObjectEncoder.encode(game_file) : game_file,
          expire_at: self.game_session_expiration_time
        }
        response = Zorkda::Db.add_game_session(game_info)
        next if response == "taken"
        return "failed" if response == "write error"
        return game_session_id
      end
    end

    def self.update_game_session(game_session_id, game_file, encode_game_file = true)
      game_info = {
        game_session_id: game_session_id,
        game_file: encode_game_file ? Zorkda::ObjectEncoder.encode(game_file) : game_file,
        expire_at: self.game_session_expiration_time
      }
      response = Zorkda::Db.update_game_session(game_info)
      return "failed" if response == "write error"
      return "success"
    end 

    def self.game_session_expiration_time
      hours_to_expire = 24
      seconds_to_expire = hours_to_expire * 60 * 60
      return Time.now.to_i + seconds_to_expire
    end

  end

end