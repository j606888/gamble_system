Rails.application.routes.draw do

  namespace :webhook do
    post 'line'
  end

  resources :line_sources

  resources :rooms

  namespace :liff do
    resources :games, only: [:index, :new, :create]
    resources :players, only: [:index, :create]
    resources :rooms, only: [:index, :create, :update] do
      member do
        post 'change'
      end
    end
  end

  resources :liff, only: [:index] do
    collection do
      get :close_window
    end
  end
  get 'liff/new_game', to: 'liff/games#new'
  get 'liff/entry', to: 'liff#entry'

  root 'rooms#index'
end
