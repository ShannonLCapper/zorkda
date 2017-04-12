module Zorkda
	module Cache

		require "redis"
    uri = URI.parse(ENV["REDISCLOUD_URL"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    $redis.config(:set, "maxmemory", "25mb")
    $redis.config(:set, "notify-keyspace-events", "xE")

    def self.get_game_session_file(game_session_id)
      response = self.get_encoded_game_session_file(game_session_id)
      return response if !response || response == "read error"
      return Zorkda::ObjectEncoder.str_to_obj(response)
    end

    def self.get_encoded_game_session_file(game_session_id)
      begin
        encoded_game_file = $redis[game_session_id]
        return encoded_game_file
      rescue Exception => e
        return "read error"
      end
    end

    def self.add_game_session(game_session_id, encoded_game_file, expire_time, error_expire_time)
      begin
        $redis[game_session_id] = encoded_game_file
        shadowkey = "shadowkey:#{game_session_id}"
        $redis[shadowkey] = ""
        $redis.expireat(shadowkey, expire_time) #Time.now.to_i + 5)
        $redis.expireat(game_session_id, error_expire_time)
        return "success"
      rescue Exception => e
        return "write error"
      end
    end

    def self.delete_game_session(game_session_id)
      begin
        $redis.del(game_session_id)
      rescue Exception => e
        # puts "error deleting game session: #{e.message}"
        return "delete error"
      end
    end

	end
end