class UsersController < ApiController
  skip_before_action :authenticate_request, only: [:create]
  before_action :authenticate_request, only: [:update, :destroy]

  def create
    user = User.new(user_params)
    if user.save!
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  rescue Exception => e
    render json: { error: e }, status: :unprocessable_entity
  end

  def update
    if @current_user.update(user_update)
      render json: { message: "Record Updated Successfully", email: @current_user.email, password: @current_user.password }, status: :ok
    else
      render json: { errors: "Unable to Update user's Data " }, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
    render json: { message: "Successfully Delete user With id #{@current_user.id}" }, status: :ok
  end

  private

  def user_params
    params.permit(:name, :email, :password, :mobile, :type)
  end

  def user_update
    params.permit(:email, :password)
  end
end
