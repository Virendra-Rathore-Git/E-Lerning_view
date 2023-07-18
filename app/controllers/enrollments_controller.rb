class EnrollmentsController < ApiController 
  before_action :check_student, only:  %i[ create update index show destroy]
  
  def create
    if Course.where(id:params[:course_id],status:"active").present?
      stud_enroll = @current_user.enrollments.new(enroll_params)
        if stud_enroll.save
          render json:{success: "Successfully Enrolled For Course",enrollments_id:stud_enroll.id}, status: :ok
        else
          render json: { errors: stud_enroll.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Courses with id #{params[:id]} not found or Course status Inactive" }, status: :unprocessable_entity      
    end
  end

  def update
      update_record = @current_user.enrollments.where(id:params[:id],status:"pending")
      if update_record.present?
        if update_record.update(params.permit(:status))
          render json:{success: "Course status updated Successfully"}, status: :ok 
        end
      else
        render json: { message: "You Already completed this Course or Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
      end
  end
  
  def destroy
    delete_enrollment = @current_user.enrollments.find_by(id:params[:id])
    if delete_enrollment.present?
      delete_enrollment.destroy
      render json: {message: "Successfully Delete Course Enrollment's"},status: :ok 
    else
      render json: {message: "Enrollment's With Id #{params[:id]} Not Found In Your Courses List"},status: :unprocessable_entity 
    end
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
