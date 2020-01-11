Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  
  get '/helps', to: "home#help"
  get '/welcome', to: 'home#welcome'
  get '/advise', to: 'home#advise'
  post '/advise', to: 'home#advise'

  resources :rooms do
    collection do
      get 'join'
      post 'verify'
      get 'verify'
      post 'sample'
    end

    member do
      post 'left'
    end

    resources :games, only: [:edit, :update, :destroy, :index, :create] do
      post 'to_csv', on: :collection
    end
    resources :players do
      post 'triggle_hidden', on: :member
    end
  end

  namespace :api do
    post 'line_callback', to: 'line_callback#index'
  end

  namespace :liff do
    get 'user'
    namespace :user do
      get 'new'
      post 'create'
    end
  end
end
