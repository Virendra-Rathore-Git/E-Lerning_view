class EnrollmentsController < ApplicationController
  before_action :check_student, only: [:create]

  def create
    # byebug
    begin
      stud_enroll = @current_user.enrollments.new(enroll_params)
      if stud_enroll.course.status == "active"
        if stud_enroll.save
          render json: stud_enroll, status: :ok
        else
          render json: { errors: stud_enroll.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "You Can Enroll Only For Acitve Courses" }, status: :unprocessable_entity
      end
    rescue
      render json: { errors: "Course With Id #{params[:course_id]} is Not Available" }, status: :unprocessable_entity
    end
  end

  private

  def enroll_params
    params.permit(:course_id)
  end
end
