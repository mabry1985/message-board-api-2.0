Rails.application.routes.draw do
  root to: 'users#new'
  concern :api_base do
    resources :groups do
      resources :messages
    end
  end

  namespace :v1 do
    concerns :api_base
  end

  post 'authenticate', to: 'authentication#authenticate'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  get '/user/:id' => 'users#show'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
end
