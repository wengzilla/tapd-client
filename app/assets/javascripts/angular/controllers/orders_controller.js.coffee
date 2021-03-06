App.controller("OrdersController", ['$scope', '$location', '$filter', 'itemsFactory', 'ordersFactory', ($scope, $location, $filter, itemsFactory, ordersFactory) ->
  $scope.items = [{id: 1, name: "Burger", price: 10.00},{id: 2, name: "Soft Drink", price: 2.50},{id: 3, name: "Fries", price: 3.50}]
  $scope.tax_rate = 0.10
  $scope.orderItems = []
  $scope.order = {}
  $scope.items = itemsFactory.items()

  $scope.$watch 'orderItems', (n, o) ->
    recalculateOrder()
  , true

  init = () ->
    $scope.getItems()

  $scope.getItems = ->
    itemsFactory.getItems()

  $scope.addItem = (item) ->
    $scope.orderItems.push(item)

  $scope.sendOrder = ->
    # console.log(angular.toJson({ "order_item_attributes": _.values(_calculateOrder()) } }))
    ordersFactory.createOrder("order": angular.toJson({ "order_items_attributes": _orderJson(), "business_id": 1 }))
    $scope.order = {}
    $scope.orderItems = []
    console.log("Sending...")

  _orderJson = ->
    items = _.uniq($scope.orderItems)
    _.map(items, (item) -> { item_id: item.id, quantity: _getQuantity(item.id) })

  recalculateOrder = ->
    $scope.lineItems = {
      order_items: _.values(_calculateOrder()),
      taxes: parseFloat(_calculateTaxes().toFixed(2)),
      total: parseFloat(_calculateTotal().toFixed(2))
    }

  _calculateOrder = ->
    items = _.uniq($scope.orderItems)
    _.reduce(items, (order, item) ->
      order[item.id] = _.extend({}, _getItem(item.id), {quantity: _getQuantity(item.id)})
      order
    , {})

  _calculateSubtotal = ->
     _.reduce($scope.orderItems, ((sum, item) -> sum + item.price), 0)

  _calculateTaxes = ->
    _calculateSubtotal() * $scope.tax_rate

  _calculateTotal = ->
    _calculateSubtotal() + _calculateTaxes()

  _getItem = (id) ->
    _.find($scope.items, (item) -> item.id == parseInt(id))

  _getQuantity = (id) ->
    _.where($scope.orderItems, {id: id}).length

  init()
])