"use strict";

(function() {
	
	angular
		.module("commandsAccordion")
		.directive("commandsAccordion", [function(){
			return {
				restrict: "E",
				templateUrl: "assets/angular/commands-accordion/commands-accordion.html",
				scope: {},
				link: function(scope, element, attrs) {
					
				}
			};
		}]);

})();