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

end