"use strict";

(function() {

  angular
    .module('streamText')
    .directive('streamText', ["$interval", "streamTextService", function($interval, streamTextService) {
      return {
        restrict: "A",
        scope: {
          textLines: "=",
          afterStream: "&"
        },
        template: '<span ng-bind-html="outputString"></span>',
        link: function(scope, element, attrs) {

          //Declare variables
          var currTextLine,
              currCharPos,
              timeoutId;
          scope.outputString = ""

          function startStream() {
            if (timeoutId) {
              cancelInterval();
            }
            scope.outputString = "";
            currTextLine = 0;
            currCharPos = 0;
            startStreamInterval();
          }

          function finishStream() {
            cancelInterval();
            if (scope.afterStream) {
              scope.afterStream();
            }
          }

          function addLetter() {
            // if ($.isArray(scope.textLines)) {
              if (currTextLine >= scope.textLines.length) {
                finishStream();
                return
              }
              var currText = scope.textLines[currTextLine];
              if (currCharPos >= currText.length) {
                scope.outputString += "<br>";
                currTextLine += 1;
                currCharPos = 0;
                addLetter();
                return
              }
              var currChar = currText[currCharPos];
              if (currChar !== "&") { //if character is not part of an html entity
                scope.outputString += currChar;
                currCharPos ++;
              } else { //print the full html entity
                var entity = "";
                while (currCharPos < currText.length) {
                  entity += currText[currCharPos];
                  currCharPos ++;
                  if (currText[currCharPos] == ";") break;
                }
                scope.outputString += entity;
              }
          }

          function startStreamInterval() {
            timeoutId = $interval(function() {
              addLetter();
            }, delay);
          }

          function updateStreamInterval() {
            if (timeoutId) {
              cancelInterval();
              timeoutId = $interval(function() {
                addLetter();
              }, delay);
            } 
          }

          function cancelInterval() {
            $interval.cancel(timeoutId);
            timeoutId = null;
          }

          //Initialize delay
          var delay = streamTextService.getDelay();
          //Watch delay in streamTextService
          scope.$watch(
            function() {return streamTextService.getDelay();},
            function(newV, oldV) {
              if (newV !== oldV) {
                delay = newV;
                updateStreamInterval();
              }
            }
          )
          
          //start streaming on element load;
          startStream();
          //Watch textLines and restart stream if it changes
          scope.$watch(
            function() {return scope.textLines;},
            function(newV, oldV) {
              if (newV !== oldV) {
                startStream();
              }
            }
          )

          //Cleanup
          element.on("$destroy", function() {
            if (timeoutId) {
              cancelInterval();
            }
          });
        }
      };
    }]);

})();