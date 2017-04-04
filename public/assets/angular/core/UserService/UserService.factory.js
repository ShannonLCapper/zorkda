"use strict";

(function() {
	
	angular
		.module("core")
		.factory("UserService", ["$cookies", "$http", function userServiceFactory($cookies, $http) {
			if (getUserCookie() === undefined) initUserCookie();
			var user
			updateUser();

			function updateUser() {
				user = $.extend(true, {}, getUserCookie());
			}

			function initUserCookie() {
				setUserCookie({
					username: null,
					signedIn: false,
					uuid: null
				})
			}

			function getUserCookie() {
				return $cookies.getObject("user");
			}

			function setUserCookie(data) {
				$cookies.putObject("user", data);
			}

			function signInLocally(username, uuid) {
				setUserCookie({
					username: username,
					signedIn: true,
					uuid: uuid
				});
				updateUser();
			}

			return {
				getUser: function() {
					return user;
				},

				signOut: function() {
					initUserCookie();
					updateUser();
				},
				signIn: function(username, password) {
					//if username not in records, status 404
					//if incorrect password, status 422
					//if successful, response data should be an object with username and uuid properties
					var promise = $http.post(
						"/user/sign-in", 
						{ username: username, password: password },
						{ responseType: "json", timeout: 8000}
					)
					//Save user's info in cookie if successful response
					promise.then(function(response) {
						signInLocally(response.data.username, response.data.uuid);
					});

					return promise;
				},

				signUp: function(username, password) {
					//if username taken, status 409
					//if successful, status 201 and data should be an object with username and uuid properties
					var promise = $http.post(
						"/user/sign-up", 
						{ username: username, password: password },
						{ responseType: "json", timeout: 10000 }
					)
					//Save user's info in cookie if successful response
					promise.then(function(response) {
						signInLocally(response.data.username, response.data.uuid);
					});

					return promise;
				}
			}
		}])

})();