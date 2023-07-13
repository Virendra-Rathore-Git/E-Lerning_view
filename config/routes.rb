Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
    post "/user/login", to: "authentication#login"

    resources :teachers,only: [:create,:update, :destroy]
    resources :students,only: [:create,:update, :destroy]
    resources :courses, only: [:create, :index, :show, :update, :destroy]
    resources :enrollments, only: [:create,:update,:index,:show,:destroy]

    get "/courses_by_name_student", to: "courses#show_by_name_cat_student"
    get "/courses_by_name", to: "courses#show_by_name_teacher"
    get "/course/status", to: "courses#show_by_status_teacher"
    get "/course/cat", to: "courses#show_by_cat_student"
end