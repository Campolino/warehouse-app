Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]

  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]

  resources :product_models, only: [:index, :show, :new, :create]

  resources :orders, only: [:index, :new, :create, :show, :edit, :update] do
    get 'search', on: :collection
    post 'delivered', on: :member
    post 'canceled', on: :member
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:show, :index]
    end
  end
end
