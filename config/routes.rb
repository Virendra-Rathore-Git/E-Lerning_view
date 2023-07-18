Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post "/user/login", to: "authentication#login"
  resource :users, only: [:create, :update, :destroy]
  resources :courses, only: [:create, :index, :show, :update, :destroy]
  resources :enrollments, only: [:create, :update, :destroy]
  resources :categories,only:[:index]
end
