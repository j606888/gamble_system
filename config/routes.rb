Rails.application.routes.draw do

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

  root 'rooms#index'
end
