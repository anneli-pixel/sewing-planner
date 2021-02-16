Rails.application.routes.draw do

  devise_for :users
  root to: 'projects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects do
    patch "change_status", on: :member
  end

  resources :patterns, only: [:new, :create, :show, :index, :edit, :update]

  resources :shopping_items, only: [:new, :create, :index] do
    patch "toggle_bought", on: :member
  end
end
