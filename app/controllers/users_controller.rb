class UsersController < ApiController
  skip_before_action :authenticate_request, only: %i[create]

  def create
    user = if params[:type].downcase == "teacher"
      Teacher.new(user_params)
    else
      Student.new(user_params)
    end
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update(user_params)
      render json: { message: "Record Updated Successfully", email: @current_user.email, password: @current_user.password }, status: :ok
    else
      render json: { errors: "Unable to Update user's Data " }, status: :unprocessable_entity
    end
  end

  def destroy
    render json: { message: "Successfully Delete user With id #{@current_user.id}" }, status: :ok if @current_user.destroy

  end

  private

  def user_params
    params.permit(:name, :email, :password, :mobile)
  end
end
