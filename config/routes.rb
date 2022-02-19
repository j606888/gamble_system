Rails.application.routes.draw do

  # line api webhook
  namespace :webhook do
    post 'line'
  end

  resources :line_sources

  resources :rooms

  namespace :liff2 do
    resources :games, only: [:index, :new, :create]
    resources :players, only: [:index, :create]
    resources :rooms, only: [:index, :create, :update] do
      member do
        post 'change'
      end
    end
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

  root 'rooms#index'
end
