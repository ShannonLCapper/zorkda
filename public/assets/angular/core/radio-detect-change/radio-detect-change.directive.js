"use strict";

(function() {

  angular
    .module('core')
    .directive('radioDetectChange', function radioDetectChange() {
      return {
        replace: false,
        require: 'ngModel',
        scope: false,
        link: function (scope, element, attrs, ngModelCtrl) {
          element.on('change', function () {
            scope.$apply(function () {
              ngModelCtrl.$setViewValue(element[0].type.toLowerCase() == 'radio' ? element[0].value : element[0].checked);
            });
          });
        }
      };
    });

})();