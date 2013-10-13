App.controller("OrderQueueController", ['$scope', '$location', '$filter', '$timeout', 'ordersFactory', ($scope, $location, $filter, $timeout, ordersFactory) ->
  $scope.orders = ordersFactory.orders()
  $scope.$watch 'orders', (n, o) ->
    console.log("TRUE")
  , true
  $scope.states = ["created,paid", "notified"]
  $scope.currentStateIndex = 0

  init = () ->
    $scope.getOrders(_currentState(), true)

  _currentState = () ->
    $scope.states[$scope.currentStateIndex]

  $scope.displayOrder = (order) ->
    $scope.currentOrder = order

  $scope.getOrders = (state, initialize=false, recurse=true) ->
    ordersFactory.getOrders({state: state}).then ->
      $scope.displayOrder(_.first($scope.orders)) if initialize

    if recurse
      $timeout(->
        $scope.getOrders(_currentState())
      , 5000)

  $scope.notifyUser = (order) ->
    ordersFactory.updateOrder(order.id, { state_event: "notify" })

  $scope.toggleState = (state) ->
    $scope.currentStateIndex = ($scope.currentStateIndex + 1) % 2
    $scope.getOrders(_currentState(), true, false)

  init()
])

#TODO: CREATED AND PAID ORDERS....