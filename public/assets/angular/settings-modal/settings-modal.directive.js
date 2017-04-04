"use strict";

(function() {
	
	angular
		.module("settingsModal")
		.directive("settingsModal", ["SettingsService", "ZorkdaSounds", function(SettingsService, ZorkdaSounds){
			return {
				restrict: "E",
				templateUrl: "assets/angular/settings-modal/settings-modal.html",
				scope: {},
				link: function(scope, element, attrs) {

					scope.playTestSound = function() {
						ZorkdaSounds.playSound("navi");
					};

					scope.playTestTextScroll = function() {
						scope.testText = [];
						scope.testText = ["Here is some text to demonstrate how fast the game text will scroll along the page."];
					};

					//Initialize popover functionality
					$("[data-toggle='popover']").popover();
					//Initialize testText
					scope.testText = [];
					//Set up 2-way binding with scope.settings and SettingsService.settings
					scope.settings = SettingsService.getSettings();
					scope.$watch(
						function() {return SettingsService.getSettings();},
						function(newV, oldV) {
							if (newV !== oldV && newV !== scope.settings) {
								scope.settings = newV;
							}
						},
						true
					);
				}
			};
		}]);

})();