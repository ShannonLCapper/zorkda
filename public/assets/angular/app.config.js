"use strict";

(function() {
	
	angular
		.module("zorkdaApp")
		.config(["$locationProvider", "$routeProvider", "$httpProvider", "$qProvider",
			function config($locationProvider, $routeProvider, $httpProvider, $qProvider) {

				$httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest";

        $qProvider.errorOnUnhandledRejections(false);

        $locationProvider.hashPrefix("");

				$routeProvider
					.when("/", {
						template: "<splash-page><landing></landing></splash-page>"
          })
					.when("/sign-in", {
						template: "<splash-page><sign-in redirect='true'></sign-in></splash-page>"
					})
          .when("/sign-in/:error", {
            template: "<splash-page><sign-in redirect='true'></sign-in></splash-page>"
          })
					.when("/sign-up", {
						template: "<splash-page><sign-up redirect='true'></sign-up></splash-page>"
					})
          .when("/new-game", {
            template: "<splash-page><new-game></new-game></splash-page>"
          })
          .when("/resume-game", {
            template: "<splash-page><resume-game></resume-game></splash-page>"
          })
					.when("/game", {
						template: "<game></game>"
					})
					.otherwise("/sign-in");
			}

		])

})();