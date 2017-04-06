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