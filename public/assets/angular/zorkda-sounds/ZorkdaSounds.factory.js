"use strict";

(function() {
	
	angular
		.module("zorkdaSounds")
		.factory("ZorkdaSounds", ["ngAudio", function ZorkdaSoundsFactory(ngAudio) {
			
			//NOTE: There is a bug in Chrome that causes the following console error when the user clicks after the first sound played on the page
			//Uncaught (in promise) DOMException: The play() request was interrupted by a call to pause().
			//This doeThis error does not actually negatively impact anything
			//See Chromium bug Issue 593273
			var sounds = {
				navi: ngAudio.load("assets/sounds/navi-hey.wav")
			}

			return {
				playSound: function(soundName) {
					sounds[soundName].play();
				},

				setVolume: function(newVol) {
					$.each(sounds, function(name, sound) {
						sound.volume = newVol;
					});
				}
			}

		}])

})();