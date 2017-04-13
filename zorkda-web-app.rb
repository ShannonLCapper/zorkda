require 'sinatra'
require 'json'
require 'byebug'
require 'rack'
require 'rack/contrib'
require './lib/zorkda-web.rb'

use Rack::PostBodyContentTypeParser
enable :sessions
set :session_secret, 'BADSECRET'

before do
  next unless request.post?
  params.each do |param, val|
    params[param] = Rack::Utils.escape_html(val)
  end
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

# for all other requests, start with...
# return if !request.xhr?

post "/user/sign-in" do
  return if !request.xhr?
  return Zorkda::User.sign_in(params["username"], params["password"])
end

post "/user/sign-up" do
  return if !request.xhr?
  return Zorkda::User.sign_up(params["username"], params["password"])
end

post "/user/game-summaries" do 
  return if !request.xhr?
  return Zorkda::GameFileHandler.get_all_game_summaries(params["uuid"])
end

post "/game/load" do
  # Response will be a status code or {gameSessionId: ..., savedGameId: ...}
  return if !request.xhr?
  return Zorkda::GameFileHandler.load_game_file(params["uuid"], params["savedGameId"])
end

post "/game/load-new" do
  # Response will be a status code or {game_session_id: ...}
  return if !request.xhr?
  return Zorkda::GameFileHandler.load_new_game_file(params["protagonistName"])
end

post "/game/start" do
  # Response will a status code or a hash with the following properties
  # outputLines(arr of strings), location(hash with area and room strings), navi(boolean)
  return if !request.xhr?
  return Zorkda::GameFileHandler.start_game(params["gameSessionId"])
end

post "/game/input" do
  # Response will be a status code or a hash with the following properties
  # outputLines(arr of strings), location(hash with area and room strings), navi(boolean)
  return if !request.xhr?
  return Zorkda::GameFileHandler.input_to_game(params["gameSessionId"], params["input"])
end

post "/game/save" do
  # Response will be error status code or {savedGameId: ...}
  return if !request.xhr?
  return Zorkda::GameFileHandler.save(params["gameSessionId"], params["uuid"], params["saveGameId"])
end

post "/game/save-new" do
  # Response will be error status code or {savedGameId: ...}
  return if !request.xhr?
  return Zorkda::GameFileHandler.save_new(params["gameSessionId"], params["uuid"])
end
