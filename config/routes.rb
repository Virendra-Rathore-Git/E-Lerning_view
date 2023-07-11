Rails.application.routes.draw do
    post "/user/login", to: "authentication#login"

    resources :teachers,only: [:create,:update, :destroy]
    resources :students,only: [:create,:update, :destroy]
    resources :courses, only: [:create, :index, :show, :update, :destroy]
    resources :enrollments, only: [:create,:update,:index,:show,:destroy]

    get "/courses_by_name/:category_id/:course_name", to: "courses#show_by_name_cat_student"
    get "/courses_by_name/:course_name", to: "courses#show_by_name_teacher"
    get "/course/status/:status", to: "courses#show_by_status_teacher"
    get "/course/cat/:category_id", to: "courses#show_by_cat_student"
    get "/all_avl_course", to: "courses#show_avl_courses_student"
end