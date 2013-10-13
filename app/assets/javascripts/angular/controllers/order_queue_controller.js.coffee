App.controller("OrderQueueController", ['$scope', '$location', '$filter', '$timeout', 'ordersFactory', ($scope, $location, $filter, $timeout, ordersFactory) ->
  $scope.orders = ordersFactory.orders()
  $scope.states = ["created,paid", "notified"]
  $scope.currentStateIndex = 0
  $scope.currentOrder = {}

  $scope.$on '$destroy', () -> 
    $timeout.cancel($scope.timeoutPromise) if $scope.timeoutPromise

  init = () ->
    $scope.getOrders(_currentState(), true)

  _currentState = () ->
    $scope.states[$scope.currentStateIndex]

  $scope.displayOrder = (order) ->
    $scope.currentOrder = order
    console.log $scope.currentOrder.user

  $scope.getOrders = (state, initialize=false, cancel=false) ->
    ordersFactory.getOrders({state: state}).then ->
      $scope.displayOrder(_.first($scope.orders)) if initialize || !_findOrder() || _findOrder().state != $scope.currentOrder.state

    $timeout.cancel($scope.timeoutPromise) if cancel && $scope.timeoutPromise
    $scope.timeoutPromise = $timeout(->
      $scope.getOrders(_currentState())
    , 1000)

  _findOrder = ->
    if $scope.currentOrder
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
    $scope.getOrders(_currentState(), true, true)

  init()
])

#TODO: CREATED AND PAID ORDERS....