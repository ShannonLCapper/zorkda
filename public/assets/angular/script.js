"use strict";

var bootstrapFocusFix = {
	init: function() {
		$("body").on("mouseup", "button, a[data-trigger!='focus'], input[type='submit']", function() {
			$(this).blur();
		});
	}
}

$(document).ready(function() {
	bootstrapFocusFix.init();
});