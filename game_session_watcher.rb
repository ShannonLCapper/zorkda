require "redis"
require "uri"
# require_relative "lib/zorkda-web.rb"

uri = URI.parse(ENV["REDISCLOUD_URL"])
redis_psub = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

loop do
  puts "hello"
  sleep(5)
end
# redis_psub.psubscribe('__keyevent@*__:expired') do |on|
#   on.pmessage do |pattern, channel, message|
#     return unless /^shadowkey:/.match(message)
#     begin
#       game_session_id = message.slice(10..-1) #removes "shadowkey:"
#       transfer_response = Zorkda::GameSessionHandler.transfer_from_cache_to_db(game_session_id)
#       return if transfer_response == "transfer error"
#       Zorkda::Cache.delete_game_session(game_session_id)
#     rescue Exception => e
#       puts "caught exception: #{e.message}"
#     end
#   end
# end