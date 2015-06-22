Rails.application.routes.draw do

  root                                   'maps#index'
  get    '/login',                   to: 'maps#login'
  get    '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout',                  to: 'sessions#destroy'
  get    '/dashboard',               to: 'dashboard#show'

  resources :events
end
