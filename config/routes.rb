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
  get'/basket', to: 'products#basket', as: "basket"
  get'/checkout', to: 'products#checkout', as: "checkout"
  post'/checkout', to: 'products#place_order', as: "place_order"
  post'/orders', to: 'orders#past_orders', as: 'post_orders'
  get'/orders', to: 'orders#past_orders', as: 'orders'
  get'/orders/:order_id', to: 'orders#order_details', as: 'order'
  get'/my_products/:id', to: 'products#my_products', as: 'my_products'
  post'/add_to_basket', to: 'products#add_to_basket', as: "add_to_basket"
  post'remove_one_from_basket', to: 'products#remove_one_from_basket', as: 'remove_one_from_basket'
  post'remove_all_from_basket', to: 'products#remove_all_from_basket', as: 'remove_all_from_basket'
end
