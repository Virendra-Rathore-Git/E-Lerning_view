class CoursesController < ApiController
  before_action :check_teacher, only: %i[create show show_by_status_teacher update destroy show_by_name_teacher]
  before_action :check_student, only: %i[show_by_name_cat_student show_by_cat_student show_avl_courses_student]

  def index
    if @current_user.type == "Teacher"
        course_data = @current_user.courses.where(course_name:params[:course_name]).or( @current_user.courses.where(status: params[:status]) )
      if course_data.present?
        course_list(course_data)    
      else 
        teachers_course = @current_user.courses
        course_list(teachers_course)
      end
    else
    cat_course = Course.where(category_id: params[:category_id], status: "active").or(Course.where(course_name:params[:course_name],status: "active"))
      if cat_course.present?
        course_list(cat_course)
      else
        all_courses = Course.where(status: "active")
        course_list(all_courses)
      end
    end  
  end

  def show
    teacher_course = @current_user.courses.find_by(id: params[:id])
    if teacher_course.present?
      render json: teacher_course,each_serializer: CourseSerializer, user: @current_user, status: :ok
    else
      render json: { errors: "Sorry Course With id #{params[:id]} is Not Available In Your Course List" }
    end
  end

  def create
    course = @current_user.courses.new(course_params)
    if course.save
      render json: course,each_serializer: CourseSerializer, user: @current_user, status: :ok
    else
      render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    course_update = @current_user.courses.find_by(id: params[:id])
    if course_update.present?
      if course_update.update(course_params)
        render json: course_update,each_serializer: CourseSerializer, user: @current_user, status: :ok
      else
        render json: { errors: "Unable to Update Course's Data" }, status: :unprocessable_entity
      end
    else
      render json: { message: "Course Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
    end
  end

  def destroy
    delete_course = @current_user.courses.find_by(id: params[:id])
    if delete_course.present?
      delete_course.destroy
      render json: { message: "Successfully Delete Course with id #{params[:id]}" }, status: :ok
    else
      render json: { message: "Course With Id #{params[:id]} Not Found In Your Courses List" }, status: :unprocessable_entity
    end
  end

  def course_list(data)
    if data.present?
      render json: data,each_serializer: CourseSerializer, user: @current_user,status: :ok
    else
      render json: { errors: "Courses Not Available" }, status: 404
    end
  end

  private

  def course_params
    params.permit(:course_name, :course_desc, :video, :category_id, :status)
  end
end
