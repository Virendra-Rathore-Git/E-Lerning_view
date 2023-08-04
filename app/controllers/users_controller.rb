class UsersController < ApiController
  # skip_before_action :authenticate_request, only: %i[index new create log   login]
    # include ActionController::Cookies


  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = if params[:type] == "teacher"
      Teacher.new(user_params)
    else
      Student.new(user_params)
    end
    if @user.save
        # UserMailer.with(user: @user).welcome_email.deliver_now
        # render json: @user, status: :created
        flash.now[:notice] = "Successfully Registerd"
    else
      flash.now[:notice] = @user.errors.full_messages
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
    params.require(:user).permit(:name, :email, :password, :mobile)
  end



end
