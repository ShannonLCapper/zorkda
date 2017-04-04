"use strict";

(function() {
	
	angular
		.module("core")
		.factory("GameService", ["$q", "$timeout", "$http", function gameServiceFactory($q, $timeout, $http) {

			var game = {
				loaded: false,
				saved: false,
				id: null
			}

			//this is temp stuff
			var loc1 = {area: "Some Place", room: "Short Room"};
			var loc2 = {area: "Another Place", room: "Very Long Room Name Right Here"};
			var currLoc = loc1;
			var playNavi = false;


			return {
				getGame: function() {
					return game;
				},

				startLoadedGame: function() {
					//server response data should be object with the following properties:
					//loaded(boolean), gameId(number or null), outputLines(array of strings), location(obj with area and room strings), and navi(boolean)
					//if loaded = false, gameId should be null and no other properties are needed
					var promise = $http.get(
						"/game/start",
						{ responseType: "json", timeout: 8000}
					);
					promise.then(function successfulCall(response) {
						game.loaded = response.data.loaded;
						game.id = response.data.gameId;
					});
					return promise
				},

				submitInput: function(input) {
					//if no input, status 400, shouldn't happen
					//if no game loaded, status 404, shouldn't happen
					//server response data should be object with the following properties:
					//outputLines(array of strings), location(obj with area and room strings), and navi(boolean)
					game.saved = false;
					var promise = $http.post(
						"/game/input",
						{ input: input },
						{ responseType: "json", timeout: 8000}
					);
					return promise
				},

				saveGame: function(uuid, targetGameId) {
					//response will be a status code or {gameId: ...}
					var promise;
					if (targetGameId === "new") {
						promise = $http.post(
							"/game/save-new",
							{ uuid: uuid },
							{ responseType: "json", timeout: 8000 }
						);
					} else {
						promise = $http.post(
							"/game/save",
							{ uuid: uuid, gameId: targetGameId },
							{ responseType: "json", timeout: 8000 }
						);
					}
					promise.then(function successfulGameSave(response) {
						game.saved = true;
						game.id = response.data.gameId;
					});
					return promise
				},

				loadGame: function(uuid, gameId) {
					//tells backend to load the game data into a cookie for easy access
					//response will just be a status code
					//400 if missing uuid or gameId
					//404 if that game doesn't exist under that uuid
					var promise = $http.post(
						"/game/load", 
						{ uuid: uuid, gameId: gameId },
						{ responseType: "json", timeout: 10000}
					);
					return promise
				},

				loadNewGame: function(protagonistName) {
					//tells backend to make a new floating game file
					//and to load the game data into a cookie for easy access
					//response will just be a status code
					//400 if missing protagonistName
					var promise = $http.post(
						"/game/load-new", 
						{ protagonistName: protagonistName },
						{ responseType: "json", timeout: 10000}
					);
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
						{ responseType: "json", timeout: 10000}
					);
					return promise;
				}
			}
		}])

})();