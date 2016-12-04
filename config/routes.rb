Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'dashboards#index'

  resources :users do
    resources :exercises
  end

  resources :dashboards, only: :index do
    collection do
      post :search, to: 'dashboards#search'
    end
  end

  resources :friendships, only: [:show, :create, :destroy]
  resources :messages, only: :create
end
