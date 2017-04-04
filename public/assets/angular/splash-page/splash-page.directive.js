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