App.factory("ordersFactory", ['$http', ($http) ->
  factory = {}
  orders = []
  order = {}

  factory.orders = () ->
    orders

  factory.getOrder = (id) ->
    promise = $http({
      method: 'GET',
      url: 'http://tapdservice.herokuapp.com/orders/' + id,
    }).success((response) ->
      angular.copy(response.order, order)
    )
    promise

  factory.getOrders = (params) ->
    promise = $http({
      method: 'GET',
      url: 'http://tapdservice.herokuapp.com/orders',
      params: params,
    }).success((response) ->
      angular.copy(response.orders, orders)
    )
    promise

  factory.notifyOrderReady = (id) ->
    console.log "here"
    promise = $http({
      method: 'GET',
      url: "http://tapdservice.herokuapp.com/orders/#{id}/send_notification"
    }).success((response) ->
      console.log "Notified: #{response.status}"
    )
    promise

  factory
])