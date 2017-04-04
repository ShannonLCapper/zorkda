"use strict";

(function() {
	
	angular
		.module("streamText")
		.factory("streamTextService", [function streamTextServiceFactory() {
			
			function calcDelay(speed) {
				return (1 - speed / 10) * .1 * 1000;
			}

			var speed = 5; //must be number between 1 and 10
			var delay = calcDelay(speed); //delay will be in milliseconds

			return {
				getSpeed: function() {
					return speed;
				},

				getDelay: function() {
					return delay;
				},

				setSpeed: function(newSpeed) { //should be number between 1 and 10
					if (newSpeed < 1) {
						newSpeed = 1;
					} else if (newSpeed > 10) {
						newSpeed = 10;
					} 
					speed = newSpeed;
					delay = calcDelay(newSpeed);
				}
			}

		}])

})();