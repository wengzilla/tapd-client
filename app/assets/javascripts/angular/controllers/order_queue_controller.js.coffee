App.controller("OrderQueueController", ['$scope', '$location', '$filter', '$timeout', 'ordersFactory', ($scope, $location, $filter, $timeout, ordersFactory) ->
  $scope.orders = ordersFactory.orders()
  $scope.$watch 'orders', (n, o) ->
    console.log("TRUE")
  , true
  $scope.states = ["created,paid", "notified"]
  $scope.currentStateIndex = 0
  $scope.currentOrder = {}

  init = () ->
    $scope.getOrders(_currentState(), true)

  _currentState = () ->
    $scope.states[$scope.currentStateIndex]

  $scope.displayOrder = (order) ->
    $scope.currentOrder = order

  $scope.getOrders = (state, initialize=false, recurse=true) ->
    ordersFactory.getOrders({state: state}).then ->
      $scope.displayOrder(_.first($scope.orders)) if initialize || !_findOrder() || _findOrder().state != $scope.currentOrder.state

    if recurse
      _currentState()
      $timeout(->
        $scope.getOrders(_currentState())
      , 1000)

  _findOrder = ->
    _.find($scope.orders, (order) -> 
      $scope.currentOrder.id == order.id
    )

  $scope.nextState = (order) ->
    if order
      if order.state == "created"
        {
          label: "Mark as Paid",
          update: () ->
            ordersFactory.updateOrder(order.id, { state_event: "submit" })
            order.state = "paid"
        }
      else
        {
          label: "Notify!",
          update: () ->
            ordersFactory.updateOrder(order.id, { state_event: "notify" })
            order.state = "notified"
        }

  $scope.toggleState = (state) ->
    $scope.currentStateIndex = ($scope.currentStateIndex + 1) % 2
    $scope.getOrders(_currentState(), true, false)

  init()
])

#TODO: CREATED AND PAID ORDERS....