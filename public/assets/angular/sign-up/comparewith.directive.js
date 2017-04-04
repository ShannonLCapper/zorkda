"use strict";

(function() {
  
  angular
    .module("signUp")
    .directive('comparewith', ['$parse', function($parse){
      return {
         require:'ngModel',
          link:function(scope, elm, attr, ngModel){
            //Can use $parse or also directly comparing with scope.$eval(attr.comparewith) will work as well
            var getter = $parse(attr.comparewith);

            ngModel.$validators.comparewith = function(val){
              return val === getter(scope).$modelValue;
            }
            scope.$watch(attr.comparewith, function(v, ov){
              if(v !== ov){
                 ngModel.$validate();
              }
            });
          }
      }
    }]);

})();