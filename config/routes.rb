Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root "users#index"
  get "/user/login", to: "application#log"
  post "/user/login", to: "application#login"

  resource :users, only: [:new, :create, :update, :destroy]
  resources :courses, only: [:new, :create, :index, :show, :update, :destroy]
  resources :enrollments, only: [:index, :create, :update, :destroy]
  resources :categories,only:[:index]
end
