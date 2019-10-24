Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :rooms do
    resources :games
    resources :players do
      member do
        post 'triggle_hidden'
      end
    end
  end
  
  resources :records
end
