class EnrollmentsController < ApiController 
  
  load_and_authorize_resource

  def index
    course = @current_user.enrollments
    render json: course, each_serializer: EnrollmentSerializer,user: @current_user
  end

  def create
     if Course.where(id: params[:course_id], status: "active").present?
      stud_enroll = @current_user.enrollments.new(enroll_params)
        if stud_enroll.save
          render json:{success: "Successfully Enrolled For Course",enrollments_id:stud_enroll.id}, status: :ok
        else
          render json: { errors: stud_enroll.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Courses with id #{params[:course_id]} not found or Course status Inactive" }, status: :unprocessable_entity      
    end
  end

  def update
      update_record = @current_user.enrollments.find_by(id:params[:id])
      render json:{success: "Course status updated Successfully"}, status: :ok if update_record.complete!
  end
  
  def destroy
      delete_enrollment = @current_user.enrollments.find_by(id:params[:id])
      delete_enrollment.destroy
      render json: {message: "Successfully Delete Course Enrollment's"},status: :ok 
  end

  def course_list(data)
    if data.length != 0
      render json: data, status: :ok
    else
      render json: {errors: "Sorry Course Not Found"},status: :unprocessable_entity
    end
  end

  private

  def enroll_params
    params.permit(:course_id)
  end
end
