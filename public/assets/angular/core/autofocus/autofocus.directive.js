"use strict";

(function() {

  angular
    .module('core')
    .directive('autofocus', ['$document', "$timeout", function($document, $timeout) {
      return {
        link: function($scope, $element, attrs) {
          $timeout(function() {
            $element[0].focus();
          }, 100);
        }
      };
    }]);

})();