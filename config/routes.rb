Client::Application.routes.draw do
  match 'partials/orders/new' => 'angular_views#orders_new'
  match 'partials/orders/index' => 'angular_views#orders_index'

  resources :orders, :only => [:show]

  root :to => 'pages#index'
end
