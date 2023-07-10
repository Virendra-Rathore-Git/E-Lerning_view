class StudentsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :check_student, only: [:update, :destroy]

  def create
    student = Student.new(student_params)
    if student.save
      render json: student, status: :created
    else
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    student_update = Student.where(id: params[:id]).find_by(id: @current_user.id)
    if !student_update.blank?
      if student_update.update(student_params)
        render json: student_update, status: :ok
      else
        render json: { errors: "Unable to Update Student's Data " }, status: :unprocessable_entity
      end
    else
      render json: { message: "Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
    end
  end

  def destroy
    student_destroy = Student.where(id: params[:id]).find_by(id: @current_user.id)
    if !student_destroy.blank?
      student_destroy.destroy
      render json: { message: "Successfully Delete Data" }, status: :ok
    else
      render json: { message: "Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
    end
  end

  private

  def student_params
    params.permit(:name, :email, :password, :mobile, :type)
  end
end
