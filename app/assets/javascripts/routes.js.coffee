App.config(['$routeProvider', ($routeProvider) -> 
  $routeProvider
    .when('/orders/',
    {
      templateUrl: 'partials/orders/index'
    })
    .when('/',
    {
      templateUrl: 'partials/orders/new'
    })
    .otherwise({ redirectTo: '/'})
])