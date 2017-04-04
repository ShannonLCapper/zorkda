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