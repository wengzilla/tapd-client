App.controller("OrderQueueController", ['$scope', '$location', '$filter', 'ordersFactory', ($scope, $location, $filter, ordersFactory) ->
  $scope.orders = ordersFactory.orders()

  init = () ->
    $scope.getOrders("created")

  $scope.displayOrder = (order) ->
    $scope.currentOrder = order

  $scope.getOrders = (state) ->
    ordersFactory.getOrders({state: state}).then ->
      $scope.displayOrder(_.first($scope.orders));

  $scope.notifyUser = (order) ->
    ordersFactory.notifyOrderReady(order.id)

  init(); 
])

#TODO: CREATED AND PAID ORDERS....