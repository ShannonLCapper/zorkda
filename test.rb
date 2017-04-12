require "redis"

# uri = URI.parse(ENV["REDISCLOUD_URL"])
redis_psub = Redis.new#(:host => uri.host, :port => uri.port, :password => uri.password)

redis_psub.psubscribe('__keyevent@*__:expired') do |on|
  on.pmessage do |pattern, channel, message|
    Zorkda::GameSessionHandler.transfer_from_redis_to_dynamo(message)
  end
end