Rails.application.routes.draw do
  resources :users
  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  get 'static_pages/index'
  get "static_pages/home"
  get 'static_pages/help'
  get 'static_pages/about'
    get 'static_pages/contact'
end
