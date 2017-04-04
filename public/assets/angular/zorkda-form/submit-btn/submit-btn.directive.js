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