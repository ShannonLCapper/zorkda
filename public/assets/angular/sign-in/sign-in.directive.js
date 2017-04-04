"use strict";

(function() {
	
	angular
		.module("signIn")
		.directive("signIn", ["UserService", "$location", "$routeParams", function(UserService, $location, $routeParams) {
			return {
				restrict: "E",
				scope: {
          redirect: "="
        },
				templateUrl: "assets/angular/sign-in/sign-in.html",
        link: function(scope, element, attrs) {
          scope.$watch(
            function() {return UserService.getUser().signedIn;},
            function(signedIn) {scope.isSignedIn = signedIn;},
            true
          );

          if ($routeParams.error === "sign-up-failure") {
            scope.signInForm.errorMsg = "You account was created successfully, but an error occurred while signing you in. Please try signing in again.";
          }
          scope.signIn = UserService.signIn;
          scope.signOut = UserService.signOut;

          scope.submitSignIn = function() {
            var signInForm = scope.signInForm
            signInForm.username.$setDirty();
            signInForm.password.$setDirty();

            if (signInForm.$valid) {
              signInForm.disableSubmitBtn = true;
              signInForm.errorMsg = "";
              scope
                .signIn(signInForm.username.$modelValue, signInForm.password.$modelValue)
                .then(
                  function signInSuccess() {
                    if (scope.redirect) {
                      $location.path("/");
                    }
                  },
                  function signInFailure(response) {
                    var status = response.status;
                    var errorMsg;
                    if (status === 404) {
                      errorMsg = "That username is not in our records";
                    } else if (status === 422) {
                      errorMsg = "That password is incorrect";
                    } else if (response.status === 400) {
                      errorMsg = "Please fill in the highlighed fields";
                    } else {
                      errorMsg = "An error occurred while processing your request. Please try again in a moment.";
                    }
                    signInForm.errorMsg = errorMsg;
                  }
                )
                .finally(function restoreSubmitBtn() {
                  signInForm.disableSubmitBtn = false;
                });
            } else {
              var errorMsg;
              var usernameError = signInForm.username.$error;
              var passwordError = signInForm.password.$error;
              if (usernameError.pattern) {
                errorMsg = "Your username cannot contain any special characters besides \" \", \"-\", \"_\", and \".\"";
              } else if (usernameError.maxlength) {
                errorMsg = "Your username cannot be over 30 characters";
              } else if (passwordError.maxlength) {
                errorMsg = "Your password cannot be over 100 characters";
              } else {
                errorMsg = "Please fill in all highlighted fields";
              }
              signInForm.errorMsg = errorMsg;
              return
            }
          };
        }
			};
		}]);

})();