# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  get '/user' => 'products#index', :as => :user_root

  resources :cart_items
  resources :checkouts, only: [:create]
  resources :shipments, only: %i[show update]
  resources :orders, only: %i[index show]
  resources :products do
    collection do
      get 'search'
      get 'mine'
    end
  end

  devise_for :users
end
