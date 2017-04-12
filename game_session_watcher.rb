require "redis"
require_relative "lib/zorkda-web.rb"

# uri = URI.parse(ENV["REDISCLOUD_URL"])
redis_psub = Redis.new#(:host => uri.host, :port => uri.port, :password => uri.password)

redis_psub.psubscribe('__keyevent@*__:expired') do |on|
  on.pmessage do |pattern, channel, message|
    return unless /^shadowkey:/.match(message)
    begin
      puts "game session expiring in cache"
      game_session_id = message.slice(10..-1) #removes "shadowkey:"
      puts "transferring from redis to dynamo"
      transfer_response = Zorkda::GameSessionHandler.transfer_from_cache_to_db(game_session_id)
      if transfer_response == "transfer error"
        puts "TRANSFER ERROR"
      else
        puts "deleting cached session"
        Zorkda::Cache.delete_game_session(game_session_id)
      end
    rescue Exception => e
      puts "caught exception: #{e.message}"
    end
  end
end