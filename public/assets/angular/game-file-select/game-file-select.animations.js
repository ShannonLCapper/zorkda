angular
	.module("gameFileSelect")
	.animation(".game-file", function phoneAnimationFactory() {
		return {
			enter: animateIn,
			move: animateIn,
			leave: animateOut
		};

		function getVerticalDimensions(element) {
			return {
				height: element.prop("scrollHeight"),
				minHeight: element.css("minHeight"),
				maxHeight: element.css("maxHeight"),
				paddingTop: element.css("paddingTop"),
				paddingBottom: element.css("paddingBottom"),
				marginTop: element.css("marginTop"),
				marginBottom: element.css("marginBottom")
			}
		}

		function animateIn(element, done) {
			var dim = getVerticalDimensions(element);
			element
				.css({
					minHeight: 0,
					height: 0,
					paddingTop: 0,
					paddingBottom: 0,
					marginTop: 0,
					marginBottom: 0,
					opacity: 0
				})
				.animate({
					minHeight: dim.minHeight,
					height: dim.height,
					paddingTop: dim.paddingTop,
					paddingBottom: dim.paddingBottom,
					marginTop: dim.marginTop,
					marginBottom: dim.marginBottom,
					opacity: 1
				}, function() {
					$(this).css("height", "auto");
					done();
				});

			return function animateInEnd(wasCanceled) {
				if (wasCanceled) element.stop();
			};
		}

		function animateOut(element, done) {
			var dim = getVerticalDimensions(element);
			element
				.css({
					minHeight: dim.minHeight,
					height: dim.height,
					paddingTop: dim.paddingTop,
					paddingBottom: dim.paddingBottom,
					marginTop: dim.marginTop,
					marginBottom: dim.marginBottom,
					opacity: 1
				})
				.animate({
					minHeight: 0,
					height: 0,
					paddingTop: 0,
					paddingBottom: 0,
					marginTop: 0,
					marginBottom: 0,
					opacity: 0
				}, done);

			return function animateOutEnd(wasCanceled) {
				if (wasCanceled) element.stop();
			};
		}
	});