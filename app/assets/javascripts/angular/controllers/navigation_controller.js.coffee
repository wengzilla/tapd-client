App.controller("NavigationsController", ['$scope', '$location', '$routeParams', ($scope, $location, $routeParams) ->
  $scope.newOrder = () ->
    $location.path() == "/"

  $scope.orderQueue = () ->
    $location.path() == "/orders/"
])