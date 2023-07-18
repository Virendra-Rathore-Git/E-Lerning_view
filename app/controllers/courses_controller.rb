class CoursesController < ApiController
  before_action :check_teacher, only: %i[create update destroy ]

  def index
    if @current_user.type == "Teacher"
      courses = @current_user.courses
      courses = courses.where("course_name LIKE ?","%#{params[:course_name]}%") if params[:course_name].present?
      courses = courses.where(status: params[:status]) if params[:status].present?
    else
      courses = Course.where(status: "active")
      courses = courses.where(category_id: params[:category_id]) if params[:category_id].present?
      courses = courses.where("course_name LIKE ?", "%#{params[:course_name]}%") if params[:course_name].present?
    end  
    course_list(courses)
  end

  def show
    if @current_user.type == "Teacher"
      courses = @current_user.courses.find_by(id: params[:id])
    else
      courses = @current_user.enrolled_courses
      courses = courses.where(id: params[:id]) if params[:id].present?
    end
    course_list(courses)
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
