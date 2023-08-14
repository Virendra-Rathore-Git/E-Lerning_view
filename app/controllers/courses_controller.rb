class CoursesController < ApiController
  include ActionController::Cookies
  before_action :authenticate_user!

    load_and_authorize_resource

    def index
    if current_user.type == "Teacher"
      courses = current_user.courses
      courses = courses.where("course_name LIKE ?","%#{params[:course_name]}%") if params[:course_name].present?
      courses = courses.where(status: params[:status]) if params[:status].present?
    else
      courses = Course.where(status: "active")
      courses = courses.where(category_id: params[:category_id]) if params[:category_id].present?
      courses = courses.where("course_name LIKE ?", "%#{params[:course_name]}%") if params[:course_name].present?
    end
    @course = courses
  end

  # def show
  #   if current_user.type == "Teacher"
  #     courses = @current_user.courses.find_by(id: params[:id])
  #   else
  #     courses = Course.where(id: params[:id],status: "active") if params[:id].present?
  #   end
  #   course_list(courses)
  # end
  # a = User.find_by(id: :id)
  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.new(course_params)
    if @course.save
     flash.now[:notice] = "Successfully Created"
      # render json: course,each_serializer: CourseSerializer, user: @current_user, status: :ok
    else
     flash.now[:notice] = @course.errors.full_messages
   end
 end

  # def update
  #   course_update = @current_user.courses.find_by(id: params[:id])
  #     if course_update.update(course_params)
  #       render json: course_update,each_serializer: CourseSerializer, user: @current_user, status: :ok
  #     else
  #       render json: { errors: "Unable to Update Course's Data" }, status: :unprocessable_entity
  #     end
  # end

  # def destroy
  #     delete_course = @current_user.courses.find_by(id: params[:id])
  #     render json: { message: "Successfully Delete Course with id #{params[:id]}" }, status: :ok if delete_course.destroy
  # end

  # def course_list(data)
  #   if data.present?
  #     # render json: {data: data} , status: :ok
  #     @course
  #   else
  #     render json: { errors: "Courses Not Available" }, status: 404
  #   end
  # end

  private

  def course_params
    params.require(:course).permit(:course_name,:teacher_id, :course_desc, :video, :category_id, :status)
  end
end
