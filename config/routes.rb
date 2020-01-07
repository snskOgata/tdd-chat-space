Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"
  resources :messages, only: :index
  resources :groups, only: [:index, :new, :create, :edit, :update]
end
