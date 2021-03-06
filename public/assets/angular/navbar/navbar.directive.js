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

					scope.closeNav = function(callback, e) {
						$(".navbar-collapse").collapse("hide");
						if (callback) callback(e)
					};

					scope.signOut = function(e) {
						var game = GameService.getGame();
						if (game.loaded && !game.saved) {
							var answer = confirm("Are you sure you want to sign out without saving your current game?");
							if (!answer) {
								e.preventDefault();
								return
							} else {
							}
						}
						UserService.signOut();
					};
				}
			};
		}]);

})();