Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  # get '/helps', to: "home#help"
  # get '/welcome', to: 'home#welcome'
  # get '/advise', to: 'home#advise'
  # post '/advise', to: 'home#advise'

  namespace :admin do
    resources :rooms
  end

  namespace :api do
    post 'line_callback', to: 'line_callback#index'
  end

  namespace :liff do
    resources :players do
      member do
        post 'trigger_hidden'
      end
    end

    namespace :rooms do
      get 'edit'
      put 'update'
      get 'show'
      post 'switch'
      post 'create'
    end

    namespace :records do
      get 'analyse'
      get 'single'
      get 'total'
    end

    namespace :games do
      get 'new'
      post 'create'
    end

    namespace :callback do
      get 'text'
      get 'entry'
      get 'exit'
    end
  end
end
