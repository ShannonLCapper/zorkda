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