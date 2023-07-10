Rails.application.routes.draw do
    post "/user/login", to: "authentication#login"

    resources :teachers
    resources :students
    resources :courses, only: [:create, :index, :show, :update, :destroy]
    resources :enrollments, only: [:create]

    get "/enrolled/courses", to: "courses#show_enroll_course_student"
    get "/courses_by_name/:course_name", to: "courses#show_by_name_student"
    get "/courses_by_name/teacher/:course_name", to: "courses#show_by_name_teacher"
    get "/course/status/:status", to: "courses#show_by_status_teacher"
    get "/course/cat/:category_id", to: "courses#show_by_cat_student"
    get "/mycourse/:course_id", to: "courses#search_in_my_course_student"
    get "/all_avl_course", to: "courses#show_avl_courses_student"
end