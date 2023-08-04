class ApplicationController < ActionController::Base
    include JsonWebToken
    def log
    end


    def login
      @current_user = User.find_by(email:params[:email])
    if @current_user && @current_user.authenticate(params[:password]) && @current_user.status == "active"
      token = jwt_encode(user_id: @current_user.id)
      cookies[:token] = token
      # @current_user
      # render json: { id: @user.id, name: @user.name, email: @user.email, token: token }, status: :ok
          redirect_to courses_path

    else
      flash.now[:errors] = 'Invalid Email Or Password Please Try Again !!'
      render :log
      # render json: { errors: "Unauthorized User" }, status: :unauthorized
    end
  end
end
