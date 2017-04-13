"use strict";

(function() {
	
	angular
		.module("game")
		.directive("game", ["GameService", "SettingsService", "ZorkdaSounds", "$sanitize", "$timeout", function(GameService, SettingsService, ZorkdaSounds, $sanitize, $timeout){
			return {
				restrict: "E",
				templateUrl: "assets/angular/game/game.html",
				scope: {},
				link: function(scope, element, attrs) {

					function pushToOutputs(newOutput) {

						// if (scope.outputs.length > 5) {
						// 	scope.outputs.shift();
						// }
						scope.outputs.push(newOutput);
					}

					function addGameOutput(data) {
						var newOutput = {
							text: data.outputLines,
							stream: true,
							navi: data.navi,
							location: data.location
						};
						pushToOutputs(newOutput);
					}

					scope.finishGameOutput = function(data) {
						updateGameLocation(data.location);
						if (data.navi) {
							ZorkdaSounds.playSound("navi");
						}
					}

					scope.startGame = function() {
						scope.retrievingGame = true;
						scope.retrievingGameError = false;
						GameService
							.startGame()
							.then(function successfulGameStart(response) {
								$timeout(function() {
									$("#userInput").focus();
								});
								updateGameLocation(response.data.location);
								scope.gameStarted = true;
								addGameOutput(response.data);
							}, function unsuccessfulGameStart(response) {
								var msg;
								if (response.status  === 404) {
									msg = "Your game session expired. Please go back to resume from the nearest savepoint, or to start a new game.";
									scope.canRetryRetrieve = false;
								} else if (response.status === 400) { //shouldn't happen
									msg = "Your game file ID didn't get sent in the request. Please go back and try loading the game again.";
									scope.canRetryRetrieve = false;
								} else {
									msg = "There was an error starting up your game. Try again in a moment.";
									scope.canRetryRetrieve = true;
								}
								scope.retrievingGameErrorMsg = msg;
								scope.retrievingGameError = true;
							})
							.finally(function() {
								scope.retrievingGame = false;
							});
					}

					function updateGameLocation(newLocation) {
						$.each( scope.location, function( key, arr) {
							if (arr[0] !== newLocation[key]) {
								arr.shift();
								arr.push(newLocation[key]);
							}
						});
					}

					scope.submitInput = function() {
						scope.form.submitDisabled = true;
						scope.loadingOutputResponse = true;
						var input = scope.userInput;
						if (!input || /[<>&]/.test(input)) {
							var errorMsg;
							if (!input) {
								errorMsg = "Please type a command."
							} else {
								errorMsg = "Your command cannot contain \"<\", \">\", or \"&\"."
							}
							pushToOutputs({
								text: errorMsg,
								error: true
							});
							scope.form.submitDisabled = false;
							scope.loadingOutputResponse = false;
							return;
						}
						scope.userInput = "";
						var newOutput = {
							text: input,
							userSupplied: true
						}
						pushToOutputs(newOutput);
						GameService.submitInput(input)
							.then(
								function successSubmitInput(response) {
									addGameOutput(response.data);
								},
								function failedSubmitInput(response) {
									var newOutput = {
										error: true
									};
									var msg;
									if (response.status === 400) {
										//this should never happen
										msg = "Please type a command.";
									} else if (response.status === 404) {
										//this should never happen
										msg = "Your game session has expired. Please go back to resume from the nearest savepoint, or to start a new game.";
									} else {
										msg = "There was an error on our end. Please try again in a moment.";
									}
									newOutput.text = msg;
									pushToOutputs(newOutput);
								})
							.finally(function restoreSubmitBtn() {
								scope.form.submitDisabled = false;
								scope.loadingOutputResponse = false;
							});
					};

					scope.toggleHelpSidebar = function() {
						scope.helpSidebarActive = !scope.helpSidebarActive;
					}
					//Initially set help-sidebar to hidden
					scope.helpSidebarActive = false;

					//Alert user if leaving page without saving
					scope.$on("$locationChangeStart", function(e, next, current) {
						if (scope.game.loaded && !scope.game.saved) {
							var answer = confirm("Are you sure you want to leave without saving?");
							if (!answer) {
								e.preventDefault();
							}
						}
					});

					//Location defaults
					scope.location = {
						area: [],
						room: []
					}
					//Input form initialization
					scope.form = {
						submitHover: false,
						submitDisabled: false
					};
					scope.userInput = "";
					//Output initialization
					scope.outputs = [];
					//Watch settings from SettingsService
					scope.settings = SettingsService.getSettings();
					scope.$watch(
						function() {return SettingsService.getSettings();},
						function(newSettings) {scope.settings = newSettings;},
						true
					);
					//Watch game from GameService
					scope.game = GameService.getGame();
					scope.$watch(
						function() {return GameService.getGame();},
						function(newV, oldV) {
							if (newV !== oldV) {
								scope.game = newV;
							}
						},
						true
					);
					//Start loaded game on page load
					scope.gameStarted = false;
					if (scope.game.loaded) {
						scope.startGame();
					}
					
				}
			};
		}]);

})();