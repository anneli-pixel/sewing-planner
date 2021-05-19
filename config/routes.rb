Rails.application.routes.draw do

  get 'home', to: 'pages#home'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects do
    patch "change_status", on: :member
  end

  resources :patterns, only: [:new, :create, :show, :index, :edit, :update, :destroy]

  resources :shopping_items, only: [:new, :create, :index, :destroy ] do
    patch "toggle_bought", on: :member
  end
end
