"use strict";

(function() {
	
	angular
		.module("saveModal")
		.directive("saveModal", ["UserService", "GameService", function(UserService, GameService){
			return {
				restrict: "E",
				templateUrl: "assets/angular/save-modal/save-modal.html",
				scope: {},
				link: function(scope, element, attrs) {
					//User 
					scope.user = UserService.getUser();
					scope.$watch(
						function() {return UserService.getUser();},
						function(userInfo, oldInfo) {
							if (userInfo !== oldInfo) {
								scope.user = userInfo;
							}
						},
						true
					);

					scope.signOut = function() {
						UserService.signOut();
						scope.resetPage();
					};

					//Page View
					scope.resetPage = function() {
						scope.page = scope.user.signedIn ? "saveForm" : "notSignedIn";
						scope.prevPages = [];
					};

					scope.isPage = function(pageName) {
						return pageName === scope.page;
					}

					scope.changePage = function(newPage) {
						scope.prevPages.unshift(scope.page);
						scope.page = newPage;
						if (newPage === "saveForm") {
						}
					};

					scope.goBack = function() {
						if (scope.prevPages.length) {
							scope.page = scope.prevPages.shift();
						}
					};

					//Modal control
					scope.closeModal = function() {
						$(element).find(".modal").modal("hide");
					}

					//Save Form View
					scope.saveFormData = {};
					scope.gameFiles = [];
          scope.loadGameSummaries = function() {
          	if (scope.user.uuid) {
	            scope.loadingGames = true;
	            scope.retrievingError = false;
	            scope.retrievingErrorMsg = "";
	            scope.retryRetrieveAllowed = false;
	            GameService
	              .getAllGameFileSummaries(scope.user.uuid)
	              .then(function successfulGameRetrieval(response){
	                scope.gameFiles = response.data;
	              }, function failedGameRetrieval(response) {
	                var errorMsg;
	                if (response.status === 400) {
	                	//this should never happen
	                  errorMsg = "Your user ID is not loaded. Try signing out and logging back in."
	                } else if (response.status === 404) {
	                	//this should never happen
	                  errorMsg = "Your user ID doesn't seem to match any in our records. Try signing out and logging back in."
	                } else {
	                  errorMsg = "There was a problem retrieving your game files. Please try again in a moment.";
	                  scope.retryRetrieveAllowed = true;
	                }
	                scope.retrievingErrorMsg = errorMsg;
	                scope.retrievingError = true;
	              })
	              .finally(function() {
	                scope.loadingGames = false;
	              });
          	} else {
          		scope.gameFiles = [];
          	}
          	//fix bug where if the new-file tab is selected to save, it still appears active afterwards
          	element.find("game-file-select .new-file").removeClass("active");
          };
          
          //Save form function
					scope.submitSaveForm = function() {
						var saveForm = scope.saveForm;
						saveForm.errorMsg = "";
						if (saveForm.$invalid) {
							saveForm.errorMsg = "Please select a game file";
							return
						}
						saveForm.disableSubmitBtn = true;
						GameService
							.saveGame(scope.user.uuid, scope.saveFormData.gameId)
							.then(function successfulGameSave() {
								scope.closeModal();
								scope.saveFormData.gameId = "";
								scope.loadGameSummaries();
							}, function failureGameSave(response) {
								var errorMsg;
								if (response.status === "404") {
									errorMsg = "Your game session has expired and can no longer be saved.";
								} else if (response.status === "400") {
									errorMsg = "Something was wrong with your request. Try logging out and signing back in.";
								} else {
									errorMsg = "An error occurred while saving your game. Please try again in a moment.";
								}
								saveForm.errorMsg = errorMsg;
							})
							.finally(function reenableSubmitBtn() {
								saveForm.disableSubmitBtn = false;
							});	
					}

					//On modal load...
					//Reset page view, set page view
					scope.resetPage();
					//Load page summaries (will only run if user is signed in)
					scope.loadGameSummaries();
					//Reset page view when modal opened
					$(element).find(".modal").on("show.bs.modal", function (e) {
						scope.$apply(function() {
							scope.resetPage();
						});
					});
					//Reset page view if user signs in, and refresh game summaries
					scope.$watch(
						function() {return scope.user.signedIn;},
						function(newV, oldV) {
							if (newV !== oldV) {
								scope.resetPage();
								scope.loadGameSummaries();
							}
						},
						true
					);

				}
			};
		}]);

})();