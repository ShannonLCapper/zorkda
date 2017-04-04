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