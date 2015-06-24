Rails.application.routes.draw do

  root                                   'maps#index'
  resources :events
  
  get    '/login',                   to: 'maps#login'
  get    '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',                  to: 'sessions#destroy'
  get    '/dashboard',               to: 'dashboard#show'

end
