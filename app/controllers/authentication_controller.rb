class AuthenticationController < ApiController
  # skip_before_action :authenticate_request

  # def login
  #   user = User.find_by_email(params[:email])
  #   if user && user.authenticate(params[:password]) && user.status == "active"
  #     token = jwt_encode(user_id: user.id)
  #     render json: { id: user.id, name: user.name, email: user.email, token: token }, status: :ok
  #   else
  #     render json: { errors: "Unauthorized User" }, status: :unauthorized
  #   end
  # end


end
