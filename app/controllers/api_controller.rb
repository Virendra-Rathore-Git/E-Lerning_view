class ApiController <  ApplicationController
	include JsonWebToken
  # before_action :current_user

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  # before_action :authenticate_request

  rescue_from ActiveRecord::RecordNotFound do|exception|
    render json: {message:exception}
  end



  rescue_from CanCan::AccessDenied do |exception|
    render json: {message: exception}
  end

  private

  # def authenticate_request
  #   begin
  #     header = request.headers["Authorization"]
  #     header = header.split(" ").last if header
  #     decoded = jwt_decode(header)
  #     @current_user = User.find(decoded[:user_id])
  #   rescue
  #     render json: {message:"Token Not Found Please Provide Token"},status: :unprocessable_entity
  #   end
  # end
end
