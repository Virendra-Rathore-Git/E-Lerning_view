class TeachersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :check_teacher, only: [:update, :destroy]

  def create
    teacher = Teacher.new(teacher_params)
    if teacher.save
      render json: teacher, status: :created
    else
      render json: { errors: teacher.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    teacher_update = Teacher.where(id: params[:id]).find_by(id: @current_user.id)
    if !teacher_update.blank?
      if teacher_update.update(params.permit(:email ,:password))
        render json: teacher_update, status: :ok
      else
        render json: { errors: "Unable to Update Teacher's Data " }, status: :unprocessable_entity
      end
    else
      render json: { message: "Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
    end
  end

  def destroy
    teacher_destroy = Teacher.where(id: params[:id]).find_by(id: @current_user.id)
    if !teacher_destroy.blank?
      teacher_destroy.destroy
      render json: { message: "Successfully Delete Data" }, status: :ok
    else
      render json: { message: "Record Not Found With id #{params[:id]}" }, status: :unprocessable_entity
    end
  end

  private

  def teacher_params
    params.permit(:name, :email, :password, :mobile)
  end
end
