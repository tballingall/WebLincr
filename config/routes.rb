Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:create, :destroy]

  get 'login' => 'sessions#new', as: 'log_in'
  get 'logout' => 'sessions#destroy', as: 'log_out'

  root 'static#home'
end
