"use strict";

(function() {
	
	angular
		.module("core")
		.factory("SettingsService", ["$cookies", "$rootScope", "ZorkdaSounds", "streamTextService", function settingsServiceFactory($cookies, $rootScope, ZorkdaSounds, streamTextService) {
			var defaultSettings = {
				volume: .5, //value between 0 and 1
				textSpeed: 7 //value between 1 and 10
			};

			//If no settings cookie exists, make one
			if (getSettingsCookie() === undefined) initSettingsCookie();

			//Sync settings variable with settings cookie
			var settings;
			updateSettings();

			//Initialize volume
			ZorkdaSounds.setVolume(settings.volume);
			//Initialize text speed
			streamTextService.setSpeed(settings.textSpeed);

			//When settings variable changes...
			$rootScope.$watch(
				function() {return settings},
				function(newV, oldV) {
					//Set sound volume
					if (newV.volume !== oldV.volume) {
						ZorkdaSounds.setVolume(newV.volume);
					}
					//Set text speed
					if (newV.textSpeed !== oldV.textSpeed) {
						streamTextService.setSpeed(newV.textSpeed);
					}
					//Update cookie
					if (newV !== oldV && !angular.equals(newV, getSettingsCookie())) {
						updateSettingsCookie();
					}
				},
				true
			);

			function initSettingsCookie() {
				setSettingsCookie($.extend(true, {}, defaultSettings));
			}

			function updateSettings() {
				settings = $.extend(true, {}, getSettingsCookie());
			}

			function updateSettingsCookie() {
				setSettingsCookie(settings);
			}

			function getSettingsCookie() {
				return $cookies.getObject("settings");
			}

			function setSettingsCookie(data) {
				$cookies.putObject("settings", data);
			}

			return {
				getSettings: function() {
					return settings;
				},

				setAllSettings: function(newSettingsObj) {
					settings = newSettingsObj;
				},

				resetAllSettings: function() {
					settings = $.extend(true, {}, defaultSettings);
				}
			}

		}])

})();