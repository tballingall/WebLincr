Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:create, :destroy]

  root 'static#home'
  get 'login' => 'sessions#new', as: 'log_in'
  get 'logout' => 'sessions#destroy', as: 'log_out'
end
