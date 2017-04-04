require 'sinatra'
require './lib/zorkda-web.rb'
require 'json'
require 'byebug'
require 'rack'
require 'rack/contrib'

use Rack::PostBodyContentTypeParser
enable :sessions
set :session_secret, 'BADSECRET'

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
  # Response will be a status code
  return if !request.xhr?
  # retrieve_game_file will either return an error status code or a game file
  game_file = Zorkda::GameFileHandler.retrieve_game_file(params["uuid"], params["gameId"])
  # Return status code if retrieve_game_file returns a error status code
  return game_file if game_file.is_a?(Numeric)
  # set game cookie
  session["game"] = {
    game_id: params["gameId"], 
    game_file: game_file
  }
  return 204
end

post "/game/load-new" do
  # Response will be a status code
  return if !request.xhr?
  # retrieve_game_file will either return an error status code or a game file
  game_file = Zorkda::GameFileHandler.initialize_game_file(params["protagonistName"])
  # Return status code if retrieve_game_file returns a error status code
  return game_file if game_file.is_a?(Numeric)
  # set game cookie
  session["game"] = {
    game_id: nil, 
    game_file: game_file
  }
  return 204
end

get "/game/start" do
  # Response will be a hash with the following properties
  # loaded(boolean), gameId(num or nil), outputLines(arr of strings),
  # location(hash with area and room strings), navi(boolean)
  # if loaded = false, gameId should be nil and no other properties needed
  return if !request.xhr?
  # retrieve game cookie
  game_cookie = session["game"]
  response = Zorkda::GameFileHandler.start_game(game_cookie)
  session["game"] = game_cookie
  return response
end

post "/game/input" do
  return if !request.xhr?
  # retrieve game cookie
  game_cookie = session["game"]
  # submit input to game file
  response = Zorkda::GameFileHandler.input_to_game(game_cookie, params["input"])
  # update game cookie
  session["game"] = game_cookie
  return response
end

post "/game/save" do
  # Response will be error status code or {gameId: ...}
  return if !request.xhr?
  # retrieve game cookie
  game_cookie = session["game"]
  # save game file
  response = Zorkda::GameFileHandler.save(game_cookie, params["uuid"], params["gameId"])
  unless response.is_a?(Numeric)
    session["game"][:game_id] = response[:gameId]
    response = response.to_json
  end
  return response
end

post "/game/save-new" do
  # Response will be error status code or {gameId: ...}
  return if !request.xhr?
  # retrieve game cookie
  game_cookie = session["game"]
  # save game file
  response = Zorkda::GameFileHandler.save_new(game_cookie, params["uuid"])
  unless response.is_a?(Numeric)
    session["game"][:game_id] = response[:gameId]
    response = response.to_json
  end
  return response
end
