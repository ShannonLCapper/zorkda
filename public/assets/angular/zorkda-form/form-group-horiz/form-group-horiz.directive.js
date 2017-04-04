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