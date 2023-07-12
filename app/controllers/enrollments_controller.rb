class EnrollmentsController < ApplicationController
  before_action :check_student, only: [:create,:update,:index,:show,:destroy]

  def index
    enroll_course = @current_user.enrollments
    course_list(enroll_course)
  end

  def show
    my_enroll_course = @current_user.enrollments.where(id: params[:id])
    course_list(my_enroll_course)
  end
  
  def create
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

  def update
    begin
      update_record=@current_user.enrollments.where(id:params[:id])
      if !update_record.blank?
        if update_record.update(params.permit(:status))
          render json: update_record
        else
          render json: { errors: "Unable to Update Enrollment's status " }, status: :unprocessable_entity
        end
      else
        render json: { message: "Course Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
      end
    rescue
      render json: { errors: "Sorry #{params[:status]} is Not Valid status please select pending or complete" }, status: :unprocessable_entity
    end
  end
  
  def destroy
    delete_enrollment=@current_user.enrollments.find_by(id:params[:id])
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
