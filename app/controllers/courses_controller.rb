class CoursesController < ApplicationController
  before_action :check_teacher, only: [:create, :index, :show, :show_by_status_teacher, :update, :destroy]
  before_action :check_student, only: [:show_student_course, :show_by_name_student, :show_by_cat_student, :show_enroll_course_student, :search_in_my_course_student, :show_avl_courses_student]

  def create
    course = @current_user.courses.new(course_params)
    if course.save
      render json: {course_details:course,video:course.video.url}
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    course_update = Course.find_by(id: params[:id], teacher_id: @current_user.id)
    if !course_update.blank?
      if course_update.update(course_params)
        render json: {course_details:course_update,video:course_update.video.url}
      else
        render json: { errors: "Unable to Update Course's Data " }, status: :unprocessable_entity
      end
    else
      render json: { message: "Course Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
    end
  end

  def index
    teachers_course = Course.where(teacher_id: @current_user.id)
    course_list(teachers_course)
  end

  def show
    teacher_course = Course.where(teacher_id: @current_user.id).find_by(id: params[:id])
    if teacher_course.present?
      render json: {course_details: teacher_course, video:teacher_course.video.url}
    else
      render json: { errors: "Sorry Course With id #{params[:id]} is Not Available In Your Course List" }
    end
  end

  def show_by_name_teacher
    name_course = Course.where(teacher_id: @current_user.id).where("course_name LIKE ?", "%#{params[:course_name]}%")

    course_list(name_course)
  end

  def show_by_status_teacher
    status_course = Course.where(teacher_id: @current_user.id).where(status: params[:status])
    course_list(status_course)
  end

  def show_avl_courses_student
    all_courses = Course.where(status: "active")
    if all_courses.length!=0
      render json: {course_details: all_courses},status: :ok
    else
      render json: { errors: "Sorry Courses Not Available" },status: :unprocessable_entity
    end
  end

  def show_by_cat_student
    cat_course = Course.where(category_id: params[:category_id], status: "active")
    if cat_course.length!=0
      render json: {course_details: cat_course},status: :ok
    else
      render json: { errors: "Sorry Course With category id #{params[:category_id]} is Not Available In Your Course List" },status: :unprocessable_entity

    end
  end

  def show_by_name_student
    name_course = Course.where("course_name LIKE ?", "%#{params[:course_name]}%").where(status: "active")
    if name_course.length!=0
      render json: {course_details: name_course},status: :ok
    else
      render json: { errors: "Sorry Course With Name #{params[:course_name]} is Not Available In Your Course List" },status: :unprocessable_entity

    end
  end

  def show_enroll_course_student
    enroll_course = Enrollment.where(student_id: @current_user.id)
    enroll_course_list(enroll_course)
  end

  def search_in_my_course_student
    my_enroll_course = Enrollment.where(student_id: @current_user.id, course_id: params[:course_id])
    enroll_course_list(my_enroll_course)
  end


  def course_list(data)
    if data.length != 0
      courses=[]
      data.each do|c|
        h=Hash.new
        h[:Course_Details]=c
        h[:video]=c.video.url
      courses.push(h)
      end
      render json: courses,status: :ok
    else
      render json: {errors: "Sorry Course Not Found"},status: :unprocessable_entity
    end
  end
def enroll_course_list(data)
    if data.length != 0
      courses=[]
      data.each do|c|
        h=Hash.new
        h[:Course_Details]=c
        h[:video]=c.course.video.url
      courses.push(h)
      end
      render json: courses,status: :ok
    else
      render json: {errors: "Sorry Course Not Found"},status: :unprocessable_entity
    end
  end

  private

  def course_params
    params.permit(:course_name, :course_desc, :video, :category_id, :status)
  end

end
