class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    # include JsonWebToken
    # def log
    # end
    def index
    end
   before_action :configure_permitted_parameters, if: :devise_controller?

  #   def login
  #     @current_user = User.find_by(email:params[:email])
  #   if @current_user && @current_user.authenticate(params[:password]) && @current_user.status == "active"
  #     token = jwt_encode(user_id: @current_user.id)
  #     cookies[:token] = token
  #     # @current_user
  #     # render json: { id: @user.id, name: @user.name, email: @user.email, token: token }, status: :ok
  #         redirect_to courses_path

  #   else
  #     flash.now[:errors] = 'Invalid Email Or Password Please Try Again !!'
  #     render :log
  #     # render json: { errors: "Unauthorized User" }, status: :unauthorized
  #   end
  # end

  private
  def configure_permitted_parameters
    # Permit the `subscribe_newsletter` parameter along with the other
    # sign up parameters.
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile, :type, :email, :password ])
  end

end
