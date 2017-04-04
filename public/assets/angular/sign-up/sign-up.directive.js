"use strict";

(function() {
	
	angular
		.module("signUp")
		.directive("signUp", ["UserService", "$location", function(UserService, $location) {
			return {
				restrict: "E",
				scope: {
					redirect: "="
				},
				templateUrl: "assets/angular/sign-up/sign-up.html",
				link: function(scope, element, attrs) {
					scope.$watch(
						function() {return UserService.getUser().signedIn;},
						function(signedIn) {scope.isSignedIn = signedIn;},
						true
					);

					scope.signUp = UserService.signUp;
					scope.signOut = UserService.signOut;
					scope.signIn = UserService.signIn;

					scope.signUpForm.passwordsMatch = function() {
						return scope.signUpForm.password.$modelValue === scope.signUpForm.passwordConf.$modelValue;
					}

					scope.submitSignUp = function() {
						var signUpForm = scope.signUpForm;
						signUpForm.errorMsg = "";
						signUpForm.username.$setDirty();
						signUpForm.password.$setDirty();
						signUpForm.passwordConf.$setDirty();

						if (signUpForm.$valid) {
							var username = signUpForm.username.$modelValue;
							var password = signUpForm.password.$modelValue;
							signUpForm.disableSubmitBtn = true;
							scope
								.signUp(username, password)
								.then(
									function signUpSuccess() {
										if (scope.redirect) {
											$location.path("/");
										} else {
											signUpForm.errorMsg = "Your account was created successfully!"
										}
										// scope
										// 	.signIn(username, password)
										// 	.then(
										// 		function signInSuccess() {
										// 			if (scope.redirect) {
										// 				$location.path("/");
										// 			}
										// 		},
										// 		function signInFailure(reason) {
										// 			if (scope.redirect) {
										// 				$location.path("/sign-in/sign-up-failure");
										// 			} else {
										// 				signUpForm.errorMsg = "Your account was created successfully, but there was an error while signing you in. Please go back and click \"Sign In\" to try again."
										// 			}
										// 		}
										// 	)
										// 	.finally(function restoreSubmitBtn() {
										// 		signUpForm.disableSubmitBtn = false;
										// 	})
									},
									function signUpFailure(response) {
										var errorMsg;
										if (response.status === 409) {
											errorMsg = "That username is already taken";
										} else if (response.status === 400) {
											errorMsg = "Please fill in the highlighed fields";
										} else {
											errorMsg = "An error occurred while processing your request. Please try again in a moment."
										}
										signUpForm.errorMsg = errorMsg;
									}
								)
								.finally(function() {
									signUpForm.disableSubmitBtn = false;
								})
						} else if (signUpForm.passwordsMatch()) {
							var errorMsg;
              var usernameError = signUpForm.username.$error;
              var passwordError = signUpForm.password.$error;
              if (usernameError.pattern) {
                errorMsg = "Your username cannot contain any special characters besides \" \", \"-\", \"_\", and \".\"";
              } else if (usernameError.maxlength) {
                errorMsg = "Your username cannot be over 30 characters";
              } else if (passwordError.maxlength) {
                errorMsg = "Your password cannot be over 100 characters";
              } else {
                errorMsg = "Please fill in all highlighted fields";
              }
              signUpForm.errorMsg = errorMsg;
              return
						} else {
							signUpForm.errorMsg = "Passwords do not match"
						}
					}
				}
			};
		}]);

})();