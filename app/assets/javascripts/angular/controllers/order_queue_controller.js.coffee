App.controller("OrderQueueController", ['$scope', '$location', '$filter', ($scope, $location, $filter) ->
  $scope.orders = [{id: 1, user: { id: 1, name: "Michael Evans", email: "michaelevans10@gmail.com", image_url: "https://lh4.googleusercontent.com/-R8wrQuXREIs/AAAAAAAAAAI/AAAAAAAAKWg/HhCRsBHdk2A/s120-c/photo.jpg" }, price: 10.00, order_items: [{"id":1,"name":"Burger","price":10,"quantity":1},{"id":2,"name":"Soft Drink","price":2.5,"quantity":2},{"id":3,"name":"Fries","price":3.5,"quantity":1}],"taxes":1.85,"total":20.35}, {id: 2, user: { id: 1, name: "Edward Weng", email: "edweng@gmail.com", image_url: "https://lh4.googleusercontent.com/--Udc9yG6NzQ/AAAAAAAAAAI/AAAAAAAAAC0/9U8SBF26X3M/s120-c/photo.jpg" }, order_items: [{"id":1,"name":"Pizza","price":15,"quantity":4},{"id":2,"name":"Soft Drink","price":2.5,"quantity":2},{"id":3,"name":"Fries","price":3.5,"quantity":1}], "total": 68.50}]


  $scope.displayOrder = (order) ->
    $scope.currentOrder = order

  $scope.displayOrder(_.first($scope.orders));
])