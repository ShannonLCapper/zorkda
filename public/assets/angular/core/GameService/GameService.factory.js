"use strict";

(function() {
	
	angular
		.module("core")
		.factory("GameService", ["$cookies", "$rootScope", "$http", function gameServiceFactory($cookies, $rootScope, $http) {

			var defaultGame = {
				loaded: false,
				gameSessionId: null,
				saved: true,
				savedGameId: null
			}

			//If no game cookie exists, make one
			if (getGameCookie() === undefined) initGameCookie();

			//Sync game variable with game cookie
			var game;
			updateGame();

			//When game variable changes...
			$rootScope.$watch(
				function() {return game},
				function(newV, oldV) {
					//Update cookie
					if (newV !== oldV && !angular.equals(newV, getGameCookie())) {
						updateGameCookie();
					}
				},
				true
			);

			function initGameCookie() {
				setGameCookie($.extend(true, {}, defaultGame));
			}

			function clearGame() {
				game = $.extend(true, {}, defaultGame);
			}

			function updateGame() {
				game = $.extend(true, {}, getGameCookie());
			}
			
			function updateGameCookie() {
				setGameCookie(game);
			}

			function getGameCookie() {
				return $cookies.getObject("game");
			}

			function setGameCookie(data) {
				$cookies.putObject("game", data);
			}

			function loadGameLocally(gameSessionId, savedGameId) {
				game = {
					loaded: true,
					gameSessionId: gameSessionId,
					saved: true,
					savedGameId: savedGameId
				}
			}

			return {
				getGame: function() {
					return game;
				},

				quitGame: clearGame,

				startGame: function() {
					//server response data should be status code or object with the following properties:
					//outputLines(array of strings), location(obj with area and room strings), and navi(boolean)
					//400 if game_session_id missing
					//404 if game_session file not there
					game.saved = false;
					var promise = $http.post(
						"/game/start",
						{ gameSessionId: game.gameSessionId },
						{ responseType: "json", timeout: 20000}
					);
					promise.then(function successfulCall(response) {
						game.loaded = true;
					});
					return promise
				},

				//TODO
				submitInput: function(input) {
					//response should be error status code or object with the following properties:
					//outputLines(array of strings), location(obj with area and room strings), and navi(boolean)
					//status 400 if input missing, shouldn't happen
					//status 404 if no game_session_id sent, or if game_session file not there
					game.saved = false;
					var promise = $http.post(
						"/game/input",
						{ gameSessionId: game.gameSessionId, input: input },
						{ responseType: "json", timeout: 20000}
					);
					return promise
				},

				saveGame: function(uuid, saveGameId) {
					//response will be a status code or {savedGameId: ...}
					var gameSessionId = game.gameSessionId;
					var promise;
					if (saveGameId === "new") {
						promise = $http.post(
							"/game/save-new",
							{ 
								uuid: uuid, 
								gameSessionId: gameSessionId 
							},
							{ responseType: "json", timeout: 20000 }
						);
					} else {
						promise = $http.post(
							"/game/save",
							{ 
								uuid: uuid, 
								gameSessionId: gameSessionId,
								saveGameId: saveGameId 
							},
							{ responseType: "json", timeout: 20000 }
						);
					}
					promise.then(function successfulGameSave(response) {
						game.saved = true;
						game.savedGameId = response.data.savedGameId;
					});
					return promise
				},

				loadGame: function(uuid, savedGameId) {
					//tells backend to load the game data into the Game Session table
					//response will just be an error status code or an object 
					//with the following properties: gameSessionId(string), savedGameId(string)
					//400 if missing uuid or gameId
					//404 if that game doesn't exist under that uuid
					var promise = $http.post(
						"/game/load", 
						{ uuid: uuid, savedGameId: savedGameId },
						{ responseType: "json", timeout: 20000 }
					);
					promise.then(function successfulGameLoad(response) {
						loadGameLocally(response.data.gameSessionId, response.data.savedGameId);
					})
					return promise
				},

				loadNewGame: function(protagonistName) {
					//tells backend to make a new game fine and load the game data into the Game Session table
					//response will just be an error status code or an object 
					//with the following properties: gameSessionId(string)
					//400 if missing protagonistName
					var promise = $http.post(
						"/game/load-new", 
						{ protagonistName: protagonistName },
						{ responseType: "json", timeout: 20000}
					);
					promise.then(function successfulGameLoad(response) {
						loadGameLocally(response.data.gameSessionId, null);
					})
					return promise
				},

				getAllGameFileSummaries: function(uuid) {
					//if uuid not present, returns 400
					//if uuid not recognized, returns 404
					//if successful, response data will be an array of game file summaries
					//(will be empty array if no games present)
					//in each summary: fileName, protagonistName, location obj with area and room props, id, and saveTimestamp
					var promise = $http.post(
						"/user/game-summaries", 
						{ uuid: uuid },
						{ responseType: "json", timeout: 20000}
					);
					return promise;
				}
			}
		}])

})();