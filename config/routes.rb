Rails.application.routes.draw do
  resources :users do
    resources :albums, shallow: true, except: :delete do
      resources :pictures, shallow: true, only: [:show, :new, :create] do
        member do
          get 'cover'
        end
      end
    end
  end

  resources :sessions, only: [:create, :destroy]

  get 'login' => 'sessions#new', as: 'log_in'
  get 'logout' => 'sessions#destroy', as: 'log_out'

  root 'static#home'
end
