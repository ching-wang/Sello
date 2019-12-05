Rails.application.routes.draw do
  
  root to: "products#index"
  get "/login", to: "sessions#new", as: "new_session"
  post "/forgot_password", to: "users#forgot_password", as: "forgot_password"
  post "/retrieve_password/", to: "users#retrieve_password", as: "retrieve_password"
  patch "/password", to: "users#password", as: "password"
  get "/account_check", to: "users#account_check", as: "account_check"
  post "/login", to: "sessions#create", as: "sessions"
  delete "/sessions", to: "sessions#destroy"
  resources :products
  resources :users, except: %i[index]
<<<<<<< HEAD
  get'/basket', to: 'products#basket', as: "basket"
  get'/checkout', to: 'products#checkout', as: "checkout"
  post'/checkout', to: 'products#place_order', as: "place_order"
  post'/orders', to: 'orders#past_orders', as: 'post_orders'
  get'/orders', to: 'orders#past_orders', as: 'orders'
  get'/orders/:order_id', to: 'orders#order_details', as: 'order'
  post'/add_to_basket', to: 'products#add_to_basket', as: "add_to_basket"
=======
  resources :orders
>>>>>>> 17115ecba55210a431183ed422722811a7f201d7
end
