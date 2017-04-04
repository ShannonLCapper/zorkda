"use strict";

(function() {
	
	angular
		.module("navbar")
		.directive("navbar", ["UserService", function(UserService){
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
						UserService.signOut();
					};
				}
			};
		}]);

})();