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

  factory.createOrder = (params) ->
    # $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
    $.ajax({
      type: 'POST',
      url: 'http://tapdservice.herokuapp.com/orders.json',
      data: params,
    }).success((response) ->
      console.log response
    )

  factory.updateOrder = (id, params) ->
    $.ajax({
      type: 'POST',
      url: 'http://tapdservice.herokuapp.com/orders/' + id,
      data: _.extend(params, {_method: 'PUT'}),
    }).success((response) ->
      console.log response
    )

  factory.notifyOrderReady = (id) ->
    promise = $http({
      method: 'GET',
      url: "http://tapdservice.herokuapp.com/orders/#{id}/send_notification"
    }).success((response) ->
      # console.log "Notified: #{response.response}"
    )
    promise

  factory
])