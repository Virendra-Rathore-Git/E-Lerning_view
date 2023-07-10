class ApplicationController < ActionController::API
  include JsonWebToken

  before_action do
    ActiveStorage::Current.url_options = { protocol: request.protocol, host: request.host, port: request.port }
  end

  before_action :authenticate_request

  private

  def authenticate_request
  	begin
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue
  	render json: {message:"Token Not Found Please Provide Token"},status: :unprocessable_entity
  end
end

  def check_student
    if @current_user.type != "Student"
      render json: { error: "Not Allowed For Teacher" }
    end
  end

  def check_teacher
    if @current_user.type != "Teacher"
      render json: { error: "Not Allowed For Student" }
    end
  end
end
