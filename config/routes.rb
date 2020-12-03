Rails.application.routes.draw do
  devise_for :users
  root to: 'projects#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :projects

  resources :patterns, only: [:new, :create, :show, :index, :edit, :update]
end
