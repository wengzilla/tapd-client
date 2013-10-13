App.factory("itemsFactory", ['$http', ($http) ->
  factory = {}
  items = []

  factory.items = () ->
    items

  factory.getItems = () ->
    promise = $http({
      method: 'GET',
      url: 'http://tapdservice.herokuapp.com/items',
      cache: true
    }).success((response) ->
      angular.copy(response.items, items)
    )
    promise

  factory
])