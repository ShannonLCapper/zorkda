"use strict";

(function() {
	
	angular.module("zorkdaApp", [
		"ngRoute",
		"ngAnimate",
		"navbar",
		"splashPage",
		"landing",
		"signIn",
		"signUp",
    "newGame",
    "resumeGame",
		"game"
	]);

})();
"use strict";

(function() {
	
	angular
		.module("core", [
			"ngCookies",
      "ngAnimate",
      "zorkdaSounds",
      "streamText"
		]);

})();
"use strict";

(function() {
	
	angular.module("game", [
		"ngSanitize",
		"luegg.directives",
		"zorkdaSounds",
		"core",
		"saveModal"
	]);

})();
"use strict";

(function() {
	
	angular
		.module("gameFileSelect", [
			"core",
  		"ngAnimate"
		])

})();
"use strict";

(function() {
	
	angular
		.module("landing", [
			"core"
		])

})();
"use strict";

(function() {
	
	angular
		.module("navbar", [
			"core",
      "settingsModal"
		]);

})();
"use strict";

(function() {
	
	angular
		.module("resumeGame", [
			"core",
      "gameFileSelect"
		])

})();
"use strict";

(function() {
	
	angular
		.module("settingsModal", [
			"core",
      "streamText"
		]);

})();
"use strict";

(function() {
	
	angular
		.module("saveModal", [
			"signIn",
      "signUp",
      "core",
      "zorkdaForm"
		]);

})();
"use strict";

(function() {
	
	angular
		.module("signIn", [
			"zorkdaForm",
			"core"
		])

})();
"use strict";

(function() {
	
	angular
		.module("signUp", [
			"zorkdaForm",
			"core"
		])

})();
"use strict";

(function() {
	
	angular.module("streamText", [
    "ngSanitize"
	]);

})();
"use strict";

(function() {
	
	angular
		.module("splashPage", [
			"core"
		])

})();
"use strict";

(function() {
	
	angular
		.module("zorkdaForm", [
      "core"
    ])

})();
"use strict";

(function() {
	
	angular
		.module("newGame", [
			"core"
		])

})();
"use strict";

(function() {
	
	angular.module("zorkdaSounds", [
		"ngAudio"
	]);

})();
"use strict";

(function() {
	
	angular
		.module("zorkdaApp")
		.config(["$locationProvider", "$routeProvider", "$httpProvider", "$qProvider",
			function config($locationProvider, $routeProvider, $httpProvider, $qProvider) {

				$httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

        $qProvider.errorOnUnhandledRejections(false);

        $locationProvider.hashPrefix("");

				$routeProvider
					.when("/", {
						template: "<splash-page><landing></landing></splash-page>"
          })
					.when("/sign-in", {
						template: "<splash-page><sign-in redirect='true'></sign-in></splash-page>"
					})
          .when("/sign-in/:error", {
            template: "<splash-page><sign-in redirect='true'></sign-in></splash-page>"
          })
					.when("/sign-up", {
						template: "<splash-page><sign-up redirect='true'></sign-up></splash-page>"
					})
          .when("/new-game", {
            template: "<splash-page><new-game></new-game></splash-page>"
          })
          .when("/resume-game", {
            template: "<splash-page><resume-game></resume-game></splash-page>"
          })
					.when("/game", {
						template: "<game></game>"
					})
					.otherwise("/sign-in");
			}

		])

})();
"use strict";

var bootstrapFocusFix = {
	init: function() {
		$("body").on("mouseup", "button, a[data-trigger!='focus'], input[type='submit']", function() {
			$(this).blur();
		});
	}
}

$(document).ready(function() {
	bootstrapFocusFix.init();
});
"use strict";

(function() {
	
	angular
		.module("zorkdaApp")
		.controller("ZorkdaAppController", ["$window", function($window) {
			this.user = {
				signedIn: true,
				username: "scapper"
			}

			this.isMobileOrTablet = function() {
  				var check = false;
				(function(a) {
					if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino|android|ipad|playbook|silk/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))) {
						check = true;
					}
				})($window.navigator.userAgent || $window.navigator.vendor || $window.opera);
				return check;
			}
		}]);

})();
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
								if (response.status  === "404") {
									msg = "Your game session expired. Please go back to resume from the nearest savepoint, or to start a new game.";
									scope.canRetryRetrieve = false;
								} else if (response.status === "400") { //shouldn't happen
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
						if (!input) {
							pushToOutputs({
								text: "Please type a command.",
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
angular
	.module("gameFileSelect")
	.animation(".game-file", function phoneAnimationFactory() {
		return {
			enter: animateIn,
			move: animateIn,
			leave: animateOut
		};

		function getVerticalDimensions(element) {
			return {
				height: element.prop("scrollHeight"),
				minHeight: element.css("minHeight"),
				maxHeight: element.css("maxHeight"),
				paddingTop: element.css("paddingTop"),
				paddingBottom: element.css("paddingBottom"),
				marginTop: element.css("marginTop"),
				marginBottom: element.css("marginBottom")
			}
		}

		function animateIn(element, done) {
			var dim = getVerticalDimensions(element);
			element
				.css({
					minHeight: 0,
					height: 0,
					paddingTop: 0,
					paddingBottom: 0,
					marginTop: 0,
					marginBottom: 0,
					opacity: 0
				})
				.animate({
					minHeight: dim.minHeight,
					height: dim.height,
					paddingTop: dim.paddingTop,
					paddingBottom: dim.paddingBottom,
					marginTop: dim.marginTop,
					marginBottom: dim.marginBottom,
					opacity: 1
				}, function() {
					$(this).css("height", "auto");
					done();
				});

			return function animateInEnd(wasCanceled) {
				if (wasCanceled) element.stop();
			};
		}

		function animateOut(element, done) {
			var dim = getVerticalDimensions(element);
			element
				.css({
					minHeight: dim.minHeight,
					height: dim.height,
					paddingTop: dim.paddingTop,
					paddingBottom: dim.paddingBottom,
					marginTop: dim.marginTop,
					marginBottom: dim.marginBottom,
					opacity: 1
				})
				.animate({
					minHeight: 0,
					height: 0,
					paddingTop: 0,
					paddingBottom: 0,
					marginTop: 0,
					marginBottom: 0,
					opacity: 0
				}, done);

			return function animateOutEnd(wasCanceled) {
				if (wasCanceled) element.stop();
			};
		}
	});
"use strict";

(function() {
	
	angular
		.module("gameFileSelect")
		.directive("gameFileSelect", ["GameService", function(GameService) {
			return {
				restrict: "E",
				scope: {
          gameFiles: "=",
          selectedGameId: "=",
          showNewFile: "=",
          selectCurrGame: "="
        },
				templateUrl: "assets/angular/game-file-select/game-file-select.html",
        link: function(scope, element, attrs) {
          if (scope.selectCurrGame) {
            scope.currGame = GameService.getGame();
            scope.selectedGameId = scope.currGame.savedGameId;
            scope.$watch(
              function() {return GameService.getGame();},
              function(newInfo, oldInfo) {
                if (newInfo !== oldInfo) {
                  scope.currGame = newInfo;
                  scope.selectedGameId = scope.currGame.savedGameId;
                }
              },
              true
            );
            scope.isCurrGame = function(id) {
              return scope.currGame.savedGameId === id;
            };
          }
        }
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("landing")
		.directive("landing", ["UserService", function(UserService) {
			return {
				restrict: "E",
				templateUrl: "assets/angular/landing/landing.html",
				scope: {},
				link: function(scope, element, attrs) {
					scope.$watch(
						function() {return UserService.getUser().signedIn;},
						function(signedIn) {scope.isSignedIn = signedIn;},
						true
					);
				}
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("navbar")
		.directive("navbar", ["UserService", "GameService", function(UserService, GameService){
			return {
				restrict: "E",
				templateUrl: "assets/angular/navbar/navbar.html",
				scope: {},
				link: function(scope, element, attrs) {
					scope.$watch(
						function() {return UserService.getUser();},
						function(userInfo) {scope.user = userInfo;},
						true
					);

					scope.closeNav = function(callback) {
						$(".navbar-collapse").collapse("hide");
						if (callback) callback()
					};

					scope.signOut = function() {
						var game = GameService.getGame();
						if (game.loaded && !game.saved) {
							var answer = confirm("Are you sure you want to sign out without saving your current game?");
							if (!answer) return;
						}
						UserService.signOut();
					};
				}
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("resumeGame")
		.directive("resumeGame", ["UserService", "GameService", "$location", function(UserService, GameService, $location) {
			return {
				restrict: "E",
				scope: {
        },
				templateUrl: "assets/angular/resume-game/resume-game.html",
        link: function(scope, element, attrs) {
          //User
          scope.user = UserService.getUser();
          scope.$watch(
            function() {return UserService.getUser();},
            function(userInfo) {scope.user = userInfo;},
            true
          );

          //Load in user's game files
          scope.gameFiles = []
          scope.loadGameSummaries = function() {
            scope.loadingGames = true;
            scope.retrievingError = false;
            scope.retrievingErrorMsg = "";
            scope.retryRetrieveAllowed = false;
            GameService
              .getAllGameFileSummaries(scope.user.uuid)
              .then(function successfulGameRetrieval(response){
                scope.gameFiles = response.data;
              }, function failedGameRetrieval(response) {
                var errorMsg;
                if (response.status === 400) {
                  //this should never happen
                  errorMsg = "Your user ID is not loaded. Try signing out and logging back in."
                } else if (response.status === 404) {
                  //this should never happen
                  errorMsg = "Your user ID doesn't seem to match any in our records. Try signing out and logging back in."
                } else {
                  errorMsg = "There was a problem retrieving your game files. Please try again in a moment.";
                  scope.retryRetrieveAllowed = true;
                }
                scope.retrievingErrorMsg = errorMsg;
                scope.retrievingError = true;
              })
              .finally(function() {
                scope.loadingGames = false;
              });
          };
          scope.loadGameSummaries(); //run loadGameSummaries on page load

          //Handle game selection
          scope.submitSelectGameForm = function() {
            var selectGameForm = scope.selectGameForm;
            selectGameForm.errorMsg = "";
            if (selectGameForm.$invalid) {
              selectGameForm.errorMsg = "Please select a game file";
              return
            }
            selectGameForm.disableSubmitBtn = true;
            GameService
              .loadGame(scope.user.uuid, scope.selectedGameId)
              .then(function successfulGameLoad() {
                $location.path("/game");
              }, function failureGameLoad(response) {
                var errorMsg;
                if (response.status === 400) {
                  //this should never happen
                  errorMsg = "Something was missing from your request. Please make sure a game file is selected. If that doesn't work, try signing out and logging back in. If this issue persists, please file a bug report."
                } else if (response.status === 404) {
                  //this should never happen
                  errorMsg = "That game file doesn't exist under your user ID. If this issue persists, please file a bug report."
                } else {
                  errorMsg = "There was a problem while loading your game file. Please try again in a moment.";
                }
                selectGameForm.errorMsg = errorMsg;
              })
              .finally(function reenabelSubmitBtn() {
                selectGameForm.disableSubmitBtn = false;
              })
              
          }
          
        }
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("settingsModal")
		.directive("settingsModal", ["SettingsService", "ZorkdaSounds", function(SettingsService, ZorkdaSounds){
			return {
				restrict: "E",
				templateUrl: "assets/angular/settings-modal/settings-modal.html",
				scope: {},
				link: function(scope, element, attrs) {

					scope.playTestSound = function() {
						ZorkdaSounds.playSound("navi");
					};

					scope.playTestTextScroll = function() {
						scope.testText = [];
						scope.testText = ["Here is some text to demonstrate how fast the game text will scroll along the page."];
					};

					//Initialize popover functionality
					$("[data-toggle='popover']").popover();
					//Initialize testText
					scope.testText = [];
					//Set up 2-way binding with scope.settings and SettingsService.settings
					scope.settings = SettingsService.getSettings();
					scope.$watch(
						function() {return SettingsService.getSettings();},
						function(newV, oldV) {
							if (newV !== oldV && newV !== scope.settings) {
								scope.settings = newV;
							}
						},
						true
					);
				}
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("saveModal")
		.directive("saveModal", ["UserService", "GameService", function(UserService, GameService){
			return {
				restrict: "E",
				templateUrl: "assets/angular/save-modal/save-modal.html",
				scope: {},
				link: function(scope, element, attrs) {
					//User 
					scope.user = UserService.getUser();
					scope.$watch(
						function() {return UserService.getUser();},
						function(userInfo, oldInfo) {
							if (userInfo !== oldInfo) {
								scope.user = userInfo;
							}
						},
						true
					);

					scope.signOut = function() {
						UserService.signOut();
						scope.resetPage();
					};

					//Page View
					scope.resetPage = function() {
						scope.page = scope.user.signedIn ? "saveForm" : "notSignedIn";
						scope.prevPages = [];
					};

					scope.isPage = function(pageName) {
						return pageName === scope.page;
					}

					scope.changePage = function(newPage) {
						scope.prevPages.unshift(scope.page);
						scope.page = newPage;
						if (newPage === "saveForm") {
						}
					};

					scope.goBack = function() {
						if (scope.prevPages.length) {
							scope.page = scope.prevPages.shift();
						}
					};

					//Modal control
					scope.closeModal = function() {
						$(element).find(".modal").modal("hide");
					}

					//Save Form View
					scope.saveFormData = {};
					scope.gameFiles = [];
          scope.loadGameSummaries = function() {
          	if (scope.user.uuid) {
	            scope.loadingGames = true;
	            scope.retrievingError = false;
	            scope.retrievingErrorMsg = "";
	            scope.retryRetrieveAllowed = false;
	            GameService
	              .getAllGameFileSummaries(scope.user.uuid)
	              .then(function successfulGameRetrieval(response){
	                scope.gameFiles = response.data;
	              }, function failedGameRetrieval(response) {
	                var errorMsg;
	                if (response.status === 400) {
	                	//this should never happen
	                  errorMsg = "Your user ID is not loaded. Try signing out and logging back in."
	                } else if (response.status === 404) {
	                	//this should never happen
	                  errorMsg = "Your user ID doesn't seem to match any in our records. Try signing out and logging back in."
	                } else {
	                  errorMsg = "There was a problem retrieving your game files. Please try again in a moment.";
	                  scope.retryRetrieveAllowed = true;
	                }
	                scope.retrievingErrorMsg = errorMsg;
	                scope.retrievingError = true;
	              })
	              .finally(function() {
	                scope.loadingGames = false;
	              });
          	} else {
          		scope.gameFiles = [];
          	}
          };
          
          //Save form function
					scope.submitSaveForm = function() {
						var saveForm = scope.saveForm;
						saveForm.errorMsg = "";
						if (saveForm.$invalid) {
							saveForm.errorMsg = "Please select a game file";
							return
						}
						saveForm.disableSubmitBtn = true;
						GameService
							.saveGame(scope.user.uuid, scope.saveFormData.gameId)
							.then(function successfulGameSave() {
								scope.closeModal();
								scope.saveFormData.gameId = "";
								scope.loadGameSummaries();
							}, function failureGameSave() {
								saveForm.errorMsg = "An error occurred while saving your game. Please try again in a moment."
							})
							.finally(function reenableSubmitBtn() {
								saveForm.disableSubmitBtn = false;
							});	
					}

					//On modal load...
					//Reset page view, set page view
					scope.resetPage();
					//Load page summaries (will only run if user is signed in)
					scope.loadGameSummaries();
					//Reset page view when modal opened
					$(element).find(".modal").on("show.bs.modal", function (e) {
						scope.$apply(function() {
							scope.resetPage();
						});
					});
					//Reset page view if user signs in, and refresh game summaries
					scope.$watch(
						function() {return scope.user.signedIn;},
						function(newV, oldV) {
							if (newV !== oldV) {
								scope.resetPage();
								scope.loadGameSummaries();
							}
						},
						true
					);

				}
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("signIn")
		.directive("signIn", ["UserService", "$location", "$routeParams", function(UserService, $location, $routeParams) {
			return {
				restrict: "E",
				scope: {
          redirect: "="
        },
				templateUrl: "assets/angular/sign-in/sign-in.html",
        link: function(scope, element, attrs) {
          scope.$watch(
            function() {return UserService.getUser().signedIn;},
            function(signedIn) {scope.isSignedIn = signedIn;},
            true
          );

          if ($routeParams.error === "sign-up-failure") {
            scope.signInForm.errorMsg = "You account was created successfully, but an error occurred while signing you in. Please try signing in again.";
          }
          scope.signIn = UserService.signIn;
          scope.signOut = UserService.signOut;

          scope.submitSignIn = function() {
            var signInForm = scope.signInForm
            signInForm.username.$setDirty();
            signInForm.password.$setDirty();

            if (signInForm.$valid) {
              signInForm.disableSubmitBtn = true;
              signInForm.errorMsg = "";
              scope
                .signIn(signInForm.username.$modelValue, signInForm.password.$modelValue)
                .then(
                  function signInSuccess() {
                    if (scope.redirect) {
                      $location.path("/");
                    }
                  },
                  function signInFailure(response) {
                    var status = response.status;
                    var errorMsg;
                    if (status === 404) {
                      errorMsg = "That username is not in our records";
                    } else if (status === 422) {
                      errorMsg = "That password is incorrect";
                    } else if (response.status === 400) {
                      errorMsg = "Please fill in the highlighed fields";
                    } else {
                      errorMsg = "An error occurred while processing your request. Please try again in a moment.";
                    }
                    signInForm.errorMsg = errorMsg;
                  }
                )
                .finally(function restoreSubmitBtn() {
                  signInForm.disableSubmitBtn = false;
                });
            } else {
              var errorMsg;
              var usernameError = signInForm.username.$error;
              var passwordError = signInForm.password.$error;
              if (usernameError.pattern) {
                errorMsg = "Your username cannot contain any special characters besides \" \", \"-\", \"_\", and \".\"";
              } else if (usernameError.maxlength) {
                errorMsg = "Your username cannot be over 30 characters";
              } else if (passwordError.maxlength) {
                errorMsg = "Your password cannot be over 100 characters";
              } else {
                errorMsg = "Please fill in all highlighted fields";
              }
              signInForm.errorMsg = errorMsg;
              return
            }
          };
        }
			};
		}]);

})();
"use strict";

(function() {
  
  angular
    .module("signUp")
    .directive('comparewith', ['$parse', function($parse){
      return {
         require:'ngModel',
          link:function(scope, elm, attr, ngModel){
            //Can use $parse or also directly comparing with scope.$eval(attr.comparewith) will work as well
            var getter = $parse(attr.comparewith);

            ngModel.$validators.comparewith = function(val){
              return val === getter(scope).$modelValue;
            }
            scope.$watch(attr.comparewith, function(v, ov){
              if(v !== ov){
                 ngModel.$validate();
              }
            });
          }
      }
    }]);

})();
"use strict";

(function() {
	
	angular
		.module("signUp")
		.directive("signUp", ["UserService", "$location", function(UserService, $location) {
			return {
				restrict: "E",
				scope: {
					redirect: "="
				},
				templateUrl: "assets/angular/sign-up/sign-up.html",
				link: function(scope, element, attrs) {
					scope.$watch(
						function() {return UserService.getUser().signedIn;},
						function(signedIn) {scope.isSignedIn = signedIn;},
						true
					);

					scope.signUp = UserService.signUp;
					scope.signOut = UserService.signOut;
					scope.signIn = UserService.signIn;

					scope.signUpForm.passwordsMatch = function() {
						return scope.signUpForm.password.$modelValue === scope.signUpForm.passwordConf.$modelValue;
					}

					scope.submitSignUp = function() {
						var signUpForm = scope.signUpForm;
						signUpForm.errorMsg = "";
						signUpForm.username.$setDirty();
						signUpForm.password.$setDirty();
						signUpForm.passwordConf.$setDirty();

						if (signUpForm.$valid) {
							var username = signUpForm.username.$modelValue;
							var password = signUpForm.password.$modelValue;
							signUpForm.disableSubmitBtn = true;
							scope
								.signUp(username, password)
								.then(
									function signUpSuccess() {
										if (scope.redirect) {
											$location.path("/");
										} else {
											signUpForm.errorMsg = "Your account was created successfully!"
										}
										// scope
										// 	.signIn(username, password)
										// 	.then(
										// 		function signInSuccess() {
										// 			if (scope.redirect) {
										// 				$location.path("/");
										// 			}
										// 		},
										// 		function signInFailure(reason) {
										// 			if (scope.redirect) {
										// 				$location.path("/sign-in/sign-up-failure");
										// 			} else {
										// 				signUpForm.errorMsg = "Your account was created successfully, but there was an error while signing you in. Please go back and click \"Sign In\" to try again."
										// 			}
										// 		}
										// 	)
										// 	.finally(function restoreSubmitBtn() {
										// 		signUpForm.disableSubmitBtn = false;
										// 	})
									},
									function signUpFailure(response) {
										var errorMsg;
										if (response.status === 409) {
											errorMsg = "That username is already taken";
										} else if (response.status === 400) {
											errorMsg = "Please fill in the highlighed fields";
										} else {
											errorMsg = "An error occurred while processing your request. Please try again in a moment."
										}
										signUpForm.errorMsg = errorMsg;
									}
								)
								.finally(function() {
									signUpForm.disableSubmitBtn = false;
								})
						} else if (signUpForm.passwordsMatch()) {
							var errorMsg;
              var usernameError = signUpForm.username.$error;
              var passwordError = signUpForm.password.$error;
              if (usernameError.pattern) {
                errorMsg = "Your username cannot contain any special characters besides \" \", \"-\", \"_\", and \".\"";
              } else if (usernameError.maxlength) {
                errorMsg = "Your username cannot be over 30 characters";
              } else if (passwordError.maxlength) {
                errorMsg = "Your password cannot be over 100 characters";
              } else {
                errorMsg = "Please fill in all highlighted fields";
              }
              signUpForm.errorMsg = errorMsg;
              return
						} else {
							signUpForm.errorMsg = "Passwords do not match"
						}
					}
				}
			};
		}]);

})();
"use strict";

(function() {

  angular
    .module('streamText')
    .directive('streamText', ["$interval", "streamTextService", function($interval, streamTextService) {
      return {
        restrict: "A",
        scope: {
          textLines: "=",
          afterStream: "&"
        },
        template: "<span ng-bind-html='outputString'></span>",
        link: function(scope, element, attrs) {

          //Declare variables
          var currTextLine,
              currCharPos,
              timeoutId;
          scope.outputString = ""

          function startStream() {
            if (timeoutId) {
              cancelInterval();
            }
            scope.outputString = "";
            currTextLine = 0;
            currCharPos = 0;
            startStreamInterval();
          }

          function finishStream() {
            cancelInterval();
            if (scope.afterStream) {
              scope.afterStream();
            }
          }

          function addLetter() {
            // if ($.isArray(scope.textLines)) {
              if (currTextLine >= scope.textLines.length) {
                finishStream();
                return
              }
              var currText = scope.textLines[currTextLine];
              if (currCharPos >= currText.length) {
                scope.outputString += "<br>";
                currTextLine += 1;
                currCharPos = 0;
                addLetter();
                return
              }
              scope.outputString += currText[currCharPos];
              currCharPos ++;
          }

          function startStreamInterval() {
            timeoutId = $interval(function() {
              addLetter();
            }, delay);
          }

          function updateStreamInterval() {
            if (timeoutId) {
              cancelInterval();
              timeoutId = $interval(function() {
                addLetter();
              }, delay);
            } 
          }

          function cancelInterval() {
            $interval.cancel(timeoutId);
            timeoutId = null;
          }

          //Initialize delay
          var delay = streamTextService.getDelay();
          //Watch delay in streamTextService
          scope.$watch(
            function() {return streamTextService.getDelay();},
            function(newV, oldV) {
              if (newV !== oldV) {
                delay = newV;
                updateStreamInterval();
              }
            }
          )
          
          //start streaming on element load;
          startStream();
          //Watch textLines and restart stream if it changes
          scope.$watch(
            function() {return scope.textLines;},
            function(newV, oldV) {
              if (newV !== oldV) {
                startStream();
              }
            }
          )

          //Cleanup
          element.on("$destroy", function() {
            if (timeoutId) {
              cancelInterval();
            }
          });
        }
      };
    }]);

})();
"use strict";

(function() {
	
	angular
		.module("streamText")
		.factory("streamTextService", [function streamTextServiceFactory() {
			
			function calcDelay(speed) {
				return (1 - speed / 10) * .1 * 1000;
			}

			var speed = 5; //must be number between 1 and 10
			var delay = calcDelay(speed); //delay will be in milliseconds

			return {
				getSpeed: function() {
					return speed;
				},

				getDelay: function() {
					return delay;
				},

				setSpeed: function(newSpeed) { //should be number between 1 and 10
					if (newSpeed < 1) {
						newSpeed = 1;
					} else if (newSpeed > 10) {
						newSpeed = 10;
					} 
					speed = newSpeed;
					delay = calcDelay(newSpeed);
				}
			}

		}])

})();
"use strict";

(function() {
	
	angular
		.module("splashPage")
		.directive("splashPage", ["UserService", function(UserService) {
			return {
				restrict: "E",
				templateUrl: "assets/angular/splash-page/splash-page.html",
				scope: {},
				transclude: true,
				link: function(scope, element, attrs) {
					scope.$watch(
						function() {return UserService.getUser();},
						function(user) {scope.user = user;},
						true
					)
				}
			}
		}]);

})();
'use strict';
angular.module('ngAudio', [])
.directive('ngAudio', ['$compile', '$q', 'ngAudio', function($compile, $q, ngAudio) {
    return {
        restrict: 'AEC',
        scope: {
            volume: '=',
            start: '=',
            currentTime: '=',
            loop: '=',
            clickPlay: '=',
            disablePreload:'='
            //ngAudio:'='
        },
        controller: function($scope, $attrs, $element, $timeout) {
            
            /* Loads the sound from destination */
            var audio;
            function initSound(){
                audio = ngAudio.load($attrs.ngAudio);
                /* Add audio to local scope for modification with nested inputs */
                $scope.$audio = audio;

                /* Remove watching features for improved performance */
                audio.unbind();
            }            

            if (!$scope.disablePreload){
                initSound();
            }        
            

            $element.on('click', function() {
                if ($scope.clickPlay === false) {
                    return;
                }
                
                if ($scope.disablePreload){
                    initSound();
                }        

                /* iOS workaround: Call the play method directly in listener function */
                audio.audio.play();
                
                /* Set volume to $scope volume if it exists, or default to audio's current value */
                audio.volume = $scope.volume || audio.volume;
                audio.loop = $scope.loop;
                audio.currentTime = $scope.start || 0;

                /* Fixes a bug with Firefox (???) */
                $timeout(function() {
                    audio.play();
                }, 5);
            });
        }
    };
}])

.directive('ngAudioHover', ['$compile', '$q', 'ngAudio', function($compile, $q, ngAudio) {
    return {
        restrict: 'AEC',
        controller: function($scope, $attrs, $element, $timeout) {

            var audio = ngAudio.load($attrs.ngAudioHover);

            $element.on('mouseover rollover hover', function() {
                
                /* iOS workaround: Call the play method directly in listener function */
                audio.audio.play();
                
                audio.volume = $attrs.volumeHover || audio.volume;
                audio.loop = $attrs.loop;
                audio.currentTime = $attrs.startHover || 0;

            });
        }
    };
}])

.service('localAudioFindingService', ['$q', function($q) {

    this.find = function(id) {
        var deferred = $q.defer();
        var $sound = document.getElementById(id);
        if ($sound) {
            deferred.resolve($sound);
        } else {
            deferred.reject(id);
        }

        return deferred.promise;
    };
}])

.service('remoteAudioFindingService', ['$q', function($q) {

    this.find = function(url) {
        var deferred = $q.defer();
        var audio = new Audio();

        audio.addEventListener('error', function() {
            deferred.reject();
        });

        audio.addEventListener('loadstart', function() {
            deferred.resolve(audio);
        });

        // bugfix for chrome...
        setTimeout(function() {
            audio.src = url;
        }, 1);

        return deferred.promise;

    };
}])

.service('cleverAudioFindingService', ['$q', 'localAudioFindingService', 'remoteAudioFindingService', function($q, localAudioFindingService, remoteAudioFindingService) {
    this.find = function(id) {
        var deferred = $q.defer();

        id = id.replace('|', '/');

        localAudioFindingService.find(id)
            .then(deferred.resolve, function() {
                return remoteAudioFindingService.find(id);
            })
            .then(deferred.resolve, deferred.reject);

        return deferred.promise;
    };
}])

.value('ngAudioGlobals', {
    muting: false,
    songmuting: false,
    performance: 25,
    unlock: true
})

.factory('NgAudioObject', ['cleverAudioFindingService', '$rootScope', '$interval', '$timeout', 'ngAudioGlobals', function(cleverAudioFindingService, $rootScope, $interval, $timeout, ngAudioGlobals) {
    return function(id) {

        if (ngAudioGlobals.unlock) {

            window.addEventListener("click",function twiddle(){
                audio.play();
                audio.pause();
                window.removeEventListener("click",twiddle);
            });

        }


        var $audioWatch,
            $willPlay = false,
            $willPause = false,
            $willRestart = false,
            $willChangePlaybackRate = false,
            $newPlaybackRate = false,
            $volumeToSet,
            $looping,
            $isMuting = false,
            $observeProperties = true,
            audio,
            audioObject = this;

        this.id = id;
        this.safeId = id.replace('/', '|');
        this.loop = 0;

        this.unbind = function() {
            $observeProperties = false;
        };

        this.play = function() {
            $willPlay = true;
            return this;
        };
        
        var completeListeners = [];
        this.complete = function(callback){
            completeListeners.push(callback);
        }

        this.pause = function() {
            $willPause = true;
        };

        this.restart = function() {
            $willRestart = true;
        };

        this.stop = function() {
            this.restart();
        };

        this.setVolume = function(volume) {
            $volumeToSet = volume;
        };

        this.setPlaybackRate = function(rate) {
            $newPlaybackRate = rate;
            $willChangePlaybackRate = true;
        };

        this.setMuting = function(muting) {
            $isMuting = muting;
        };

        this.setProgress = function(progress) {
            if (audio && audio.duration && isFinite(progress)) {
                audio.currentTime = audio.duration * progress;
            }
        };

        this.setCurrentTime = function(currentTime) {
            if (audio && audio.duration) {
                audio.currentTime = currentTime;
            }
        };

        function $setWatch() {
            $audioWatch = $rootScope.$watch(function() {
                return {
                    volume: audioObject.volume,
                    currentTime: audioObject.currentTime,
                    progress: audioObject.progress,
                    muting: audioObject.muting,
                    loop: audioObject.loop,
                    playbackRate: audioObject.playbackRate
                };
            }, function(newValue, oldValue) {
                if (newValue.currentTime !== oldValue.currentTime) {
                    audioObject.setCurrentTime(newValue.currentTime);
                }

                if (newValue.progress !== oldValue.progress) {
                    audioObject.setProgress(newValue.progress);
                }
                if (newValue.volume !== oldValue.volume) {
                    audioObject.setVolume(newValue.volume);
                }

                if (newValue.playbackRate !== oldValue.playbackRate) {
                    audioObject.setPlaybackRate(newValue.playbackRate);
                }



                $looping = newValue.loop;

                if (newValue.muting !== oldValue.muting) {
                    audioObject.setMuting(newValue.muting);
                }
            }, true);
        }

        cleverAudioFindingService.find(id)
            .then(function(nativeAudio) {
                audio = nativeAudio;
                audio.addEventListener('canplay', function() {
                    audioObject.canPlay = true;
                });


            }, function(error) {
                audioObject.error = true;
                console.warn(error);
            });


        var interval = $interval(checkWatchers, ngAudioGlobals.performance);
        $rootScope.$watch(function(){
            return ngAudioGlobals.performance;
        },function(){
            $interval.cancel(interval);
            interval = $interval(checkWatchers, ngAudioGlobals.performance);
        })
        
        function checkWatchers() {
            if ($audioWatch) {
                $audioWatch();
            }
            if (audio) {

                if ($isMuting || ngAudioGlobals.isMuting) {
                    audio.volume = 0;
                } else {
                    audio.volume = audioObject.volume !== undefined ? audioObject.volume : 1;
                }

                if ($willPlay) {
                    audio.play();
                    $willPlay = false;
                }

                if ($willRestart) {
                    audio.pause();
                    audio.currentTime = 0;
                    $willRestart = false;
                }

                if ($willPause) {
                    audio.pause();
                    $willPause = false;
                }

                if ($willChangePlaybackRate) {
                    audio.playbackRate = $newPlaybackRate;
                    $willChangePlaybackRate = false;
                }

                if ($volumeToSet) {
                    audio.volume = $volumeToSet;
                    $volumeToSet = undefined;
                }

                if ($observeProperties) {
                    audioObject.currentTime = audio.currentTime;
                    audioObject.duration = audio.duration;
                    audioObject.remaining = audio.duration - audio.currentTime;
                    audioObject.progress = audio.currentTime / audio.duration;
                    audioObject.paused = audio.paused;
                    audioObject.src = audio.src;
                    
                    if (audioObject.currentTime >= audioObject.duration) {
                        completeListeners.forEach(function(listener){
                            listener(audioObject);
                        })
                    }

                    if ($looping && audioObject.currentTime >= audioObject.duration) {
                        if ($looping !== true) {
                            $looping--;
                            audioObject.loop--;
                            // if (!$looping) return;
                        }
                        audioObject.setCurrentTime(0);
                        audioObject.play();

                    }
                }

                if (!$isMuting && !ngAudioGlobals.isMuting) {
                    audioObject.volume = audio.volume;
                }

                audioObject.audio = audio;
            }

            $setWatch();
        }
    };
}])
.service('ngAudio', ['NgAudioObject', 'ngAudioGlobals', function(NgAudioObject, ngAudioGlobals) {
    this.play = function(id) {

        var audio = new NgAudioObject(id);
        audio.play();
        return audio;
    };

    this.load = function(id) {
        return new NgAudioObject(id);
    };

    this.mute = function() {
        ngAudioGlobals.muting = true;
    };

    this.unmute = function() {
        ngAudioGlobals.muting = false;
    };

    this.toggleMute = function() {
        ngAudioGlobals.muting = !ngAudioGlobals.muting;
    };

    this.setUnlock = function(unlock) {
      ngAudioGlobals.unlock = unlock;
    };
}])
.filter("trackTime", function(){
    /* Conveniently takes a number and returns the track time */
    
    return function(input){

        var totalSec = Math.floor(input | 0);

        var output = "";
        var hours = 0;
        var minutes = 0;
        var seconds = 0;

        if (totalSec > 3599) {

            hours = Math.floor(totalSec / 3600);
            minutes = Math.floor((totalSec - (hours * 3600)) / 60);
            seconds = (totalSec - ((minutes * 60) + (hours * 3600))); 

            if (hours.toString().length == 1) {
                hours = "0" + (Math.floor(totalSec / 3600)).toString();
            } 

            if (minutes.toString().length == 1) {
                minutes = "0" + (Math.floor((totalSec - (hours * 3600)) / 60)).toString();
            } 

            if (seconds.toString().length == 1) {
                seconds = "0" + (totalSec - ((minutes * 60) + (hours * 3600))).toString(); 
            } 

            output = hours + ":" + minutes + ":" + seconds;

        } else if (totalSec > 59) {

            minutes = Math.floor(totalSec / 60);
            seconds = totalSec - (minutes * 60);

            if (minutes.toString().length == 1) {
                 minutes = "0" + (Math.floor(totalSec / 60)).toString();
            }

            if (seconds.toString().length == 1) {
                 seconds = "0" + (totalSec - (minutes * 60)).toString();
            }

            output = minutes + ":" + seconds;

        } else {

            seconds = totalSec;

            if (seconds.toString().length == 1) {
                seconds = "0" + (totalSec).toString();
            }

            output = totalSec + "s";

        }
        
        if (Number.isNaN(output)){
            debugger;
        }

        return output; 
    }
});

/* angularjs Scroll Glue
 * version 2.1.0
 * https://github.com/Luegg/angularjs-scroll-glue
 * An AngularJs directive that automatically scrolls to the bottom of an element on changes in it's scope.
*/

// Allow module to be loaded via require when using common js. e.g. npm
if(typeof module === "object" && module.exports){
    module.exports = 'luegg.directives';
}

(function(angular, undefined){
    'use strict';

    function createActivationState($parse, attr, scope){
        function unboundState(initValue){
            var activated = initValue;
            return {
                getValue: function(){
                    return activated;
                },
                setValue: function(value){
                    activated = value;
                }
            };
        }

        function oneWayBindingState(getter, scope){
            return {
                getValue: function(){
                    return getter(scope);
                },
                setValue: function(){}
            };
        }

        function twoWayBindingState(getter, setter, scope){
            return {
                getValue: function(){
                    return getter(scope);
                },
                setValue: function(value){
                    if(value !== getter(scope)){
                        scope.$apply(function(){
                            setter(scope, value);
                        });
                    }
                }
            };
        }

        if(attr !== ""){
            var getter = $parse(attr);
            if(getter.assign !== undefined){
                return twoWayBindingState(getter, getter.assign, scope);
            } else {
                return oneWayBindingState(getter, scope);
            }
        } else {
            return unboundState(true);
        }
    }

    function createDirective(module, attrName, direction){
        module.directive(attrName, ['$parse', '$window', '$timeout', function($parse, $window, $timeout){
            return {
                priority: 1,
                restrict: 'A',
                link: function(scope, $el, attrs){
                    var el = $el[0],
                        activationState = createActivationState($parse, attrs[attrName], scope);

                    function scrollIfGlued() {
                        if(activationState.getValue() && !direction.isAttached(el)){
                            // Ensures scroll after angular template digest
                            $timeout(function() {
                              direction.scroll(el);
                            });
                        }
                    }

                    function onScroll() {
                        activationState.setValue(direction.isAttached(el));
                    }

                    $timeout(scrollIfGlued, 0, false);

                    if (!$el[0].hasAttribute('force-glue')) {
                      $el.on('scroll', onScroll);
                    }

                    var hasAnchor = false;
                    angular.forEach($el.children(), function(child) {
                      if (child.hasAttribute('scroll-glue-anchor')) {
                        hasAnchor = true;
                        scope.$watch(function() { return child.offsetHeight }, function() {
                          scrollIfGlued();
                        });
                      }
                    });

                    if (!hasAnchor) {
                      scope.$watch(scrollIfGlued);
                      $window.addEventListener('resize', scrollIfGlued, false);
                    }

                    // Remove listeners on directive destroy
                    $el.on('$destroy', function() {
                        $el.unbind('scroll', onScroll);
                    });

                    scope.$on('$destroy', function() {
                        $window.removeEventListener('resize', scrollIfGlued, false);
                    });
                }
            };
        }]);
    }

    var bottom = {
        isAttached: function(el){
            // + 1 catches off by one errors in chrome
            return el.scrollTop + el.clientHeight + 1 >= el.scrollHeight;
        },
        scroll: function(el){
            el.scrollTop = el.scrollHeight;
        }
    };

    var top = {
        isAttached: function(el){
            return el.scrollTop <= 1;
        },
        scroll: function(el){
            el.scrollTop = 0;
        }
    };

    var right = {
        isAttached: function(el){
            return el.scrollLeft + el.clientWidth + 1 >= el.scrollWidth;
        },
        scroll: function(el){
            el.scrollLeft = el.scrollWidth;
        }
    };

    var left = {
        isAttached: function(el){
            return el.scrollLeft <= 1;
        },
        scroll: function(el){
            el.scrollLeft = 0;
        }
    };

    var module = angular.module('luegg.directives', []);

    createDirective(module, 'scrollGlue', bottom);
    createDirective(module, 'scrollGlueTop', top);
    createDirective(module, 'scrollGlueBottom', bottom);
    createDirective(module, 'scrollGlueLeft', left);
    createDirective(module, 'scrollGlueRight', right);
}(angular));

"use strict";

(function() {
	
	angular
		.module("newGame")
		.directive("newGame", ["GameService", "$location", function(GameService, $location) {
			return {
				restrict: "E",
				scope: {
        },
				templateUrl: "assets/angular/new-game/new-game.html",
        link: function(scope, element, attrs) {
          scope.submitNewGameForm = function() {
            var newGameForm = scope.newGameForm;
            newGameForm.errorMsg = "";
            if (newGameForm.$invalid) {
              var errorMsg;
              var $error = newGameForm.charName.$error;
              if ($error.required) {
                errorMsg = "You need to choose a name";
              } else if ($error.pattern) {
                errorMsg = "Your character's name cannot contain any special characters besides \" \", \"-\", \"_\", \".\", and \" ' \"";
              } else if ($error.maxlength) {
                errorMsg = "Your character's name cannot be over 20 characters";
              }
              newGameForm.errorMsg = errorMsg;
              return
            }
            newGameForm.disableSubmitBtn = true;
            GameService
              .loadNewGame(scope.characterName)
              .then(function successfulGameLoad() {
                $location.path("/game");
              }, function failureGameLoad(response) {
                var errorMsg;
                if (response.status === 400) { //missing field, shouldn't happen
                  errorMsg = "You need to choose a name";
                } else {
                  errorMsg = "There was a problem loading your game. Please try again in a moment.";
                }
                newGameForm.errorMsg = errorMsg;
              })
              .finally(function reenabelSubmitBtn() {
                newGameForm.disableSubmitBtn = false;
              })
              
          }
        }
			};
		}]);

})();
"use strict";

(function() {
	
	angular
		.module("zorkdaSounds")
		.factory("ZorkdaSounds", ["ngAudio", function ZorkdaSoundsFactory(ngAudio) {
			
			//NOTE: There is a bug in Chrome that causes the following console error when the user clicks after the first sound played on the page
			//Uncaught (in promise) DOMException: The play() request was interrupted by a call to pause().
			//This doeThis error does not actually negatively impact anything
			//See Chromium bug Issue 593273
			var sounds = {
				navi: ngAudio.load("assets/sounds/navi-hey.wav")
			}

			return {
				playSound: function(soundName) {
					sounds[soundName].play();
				},

				setVolume: function(newVol) {
					$.each(sounds, function(name, sound) {
						sound.volume = newVol;
					});
				}
			}

		}])

})();
"use strict";

(function() {

  angular
    .module('core')
    .directive('autofocus', ['$document', "$timeout", function($document, $timeout) {
      return {
        link: function($scope, $element, attrs) {
          $timeout(function() {
            $element[0].focus();
          }, 100);
        }
      };
    }]);

})();
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
"use strict";

(function() {
  
  angular
    .module("core")
    .component("loadingIcon", {
      templateUrl: "assets/angular/core/loading-icon/loading-icon.html"
    });

})();
"use strict";

(function() {

  angular
    .module('core')
    .directive('radioDetectChange', function radioDetectChange() {
      return {
        replace: false,
        require: 'ngModel',
        scope: false,
        link: function (scope, element, attrs, ngModelCtrl) {
          element.on('change', function () {
            scope.$apply(function () {
              ngModelCtrl.$setViewValue(element[0].type.toLowerCase() == 'radio' ? element[0].value : element[0].checked);
            });
          });
        }
      };
    });

})();
"use strict";

(function() {
	
	angular
		.module("core")
		.factory("SettingsService", ["$cookies", "$rootScope", "ZorkdaSounds", "streamTextService", function settingsServiceFactory($cookies, $rootScope, ZorkdaSounds, streamTextService) {
			var defaultSettings = {
				volume: .5, //value between 0 and 1
				textSpeed: 7 //value between 1 and 10
			};

			//If no settings cookie exists, make one
			if (getSettingsCookie() === undefined) initSettingsCookie();

			//Sync settings variable with settings cookie
			var settings;
			updateSettings();

			//Initialize volume
			ZorkdaSounds.setVolume(settings.volume);
			//Initialize text speed
			streamTextService.setSpeed(settings.textSpeed);

			//When settings variable changes...
			$rootScope.$watch(
				function() {return settings},
				function(newV, oldV) {
					//Set sound volume
					if (newV.volume !== oldV.volume) {
						ZorkdaSounds.setVolume(newV.volume);
					}
					//Set text speed
					if (newV.textSpeed !== oldV.textSpeed) {
						streamTextService.setSpeed(newV.textSpeed);
					}
					//Update cookie
					if (newV !== oldV && !angular.equals(newV, getSettingsCookie())) {
						updateSettingsCookie();
					}
				},
				true
			);

			function initSettingsCookie() {
				setSettingsCookie($.extend(true, {}, defaultSettings));
			}

			function updateSettings() {
				settings = $.extend(true, {}, getSettingsCookie());
			}

			function updateSettingsCookie() {
				setSettingsCookie(settings);
			}

			function getSettingsCookie() {
				return $cookies.getObject("settings");
			}

			function setSettingsCookie(data) {
				$cookies.putObject("settings", data);
			}

			return {
				getSettings: function() {
					return settings;
				},

				setAllSettings: function(newSettingsObj) {
					settings = newSettingsObj;
				},

				resetAllSettings: function() {
					settings = $.extend(true, {}, defaultSettings);
				}
			}

		}])

})();
"use strict";

(function() {
	
	angular
		.module("core")
		.factory("UserService", ["$cookies", "$http", "GameService", function userServiceFactory($cookies, $http, GameService) {
			if (getUserCookie() === undefined) initUserCookie();
			var user
			updateUser();

			function updateUser() {
				user = $.extend(true, {}, getUserCookie());
			}

			function initUserCookie() {
				setUserCookie({
					username: null,
					signedIn: false,
					uuid: null
				})
			}

			function getUserCookie() {
				return $cookies.getObject("user");
			}

			function setUserCookie(data) {
				$cookies.putObject("user", data);
			}

			function signInLocally(username, uuid) {
				setUserCookie({
					username: username,
					signedIn: true,
					uuid: uuid
				});
				updateUser();
			}

			return {
				getUser: function() {
					return user;
				},

				signOut: function() {
					GameService.quitGame();
					initUserCookie();
					updateUser();
				},

				signIn: function(username, password) {
					//if username not in records, status 404
					//if incorrect password, status 422
					//if successful, response data should be an object with username and uuid properties
					var promise = $http.post(
						"/user/sign-in", 
						{ username: username, password: password },
						{ responseType: "json", timeout: 8000}
					)
					//Save user's info in cookie if successful response
					promise.then(function(response) {
						signInLocally(response.data.username, response.data.uuid);
					});

					return promise;
				},

				signUp: function(username, password) {
					//if username taken, status 409
					//if successful, status 201 and data should be an object with username and uuid properties
					var promise = $http.post(
						"/user/sign-up", 
						{ username: username, password: password },
						{ responseType: "json", timeout: 10000 }
					)
					//Save user's info in cookie if successful response
					promise.then(function(response) {
						signInLocally(response.data.username, response.data.uuid);
					});

					return promise;
				}
			}
		}])

})();
"use strict";

(function() {
	
	angular
		.module("zorkdaForm")
		.directive("formGroupHoriz", function() {
			return {
				restrict: "E",
				scope: {
					label: "@",
					animation: "@",
					required: "="
				},
				transclude: true,
				templateUrl: "assets/angular/zorkda-form/form-group-horiz/form-group-horiz.html"
			};
		});

})();
"use strict";

(function() {
	
	angular
		.module("zorkdaForm")
		.directive("submitBtn", function() {
			return {
				restrict: "E",
				scope: {
					label: "@",
					isDisabled: "="
				},
				templateUrl: "assets/angular/zorkda-form/submit-btn/submit-btn.html"
			};
		});

})();