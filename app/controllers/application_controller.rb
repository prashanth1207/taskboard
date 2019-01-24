class ApplicationController < ActionController::API
  include ActionController::Serialization
  before_action :authenticate_request

  attr_reader :current_user

  include GlobalExceptionHandler

  private

  def authenticate_request
    auth_header = request.headers['Authorization'].presence
    if auth_header
      auth_token = auth_header.split(' ').last
      @current_user = User.find_by(auth_token: auth_token)
    end
    access_denied unless current_user
  end

  def access_denied(message = 'Access denied')
    error = { error: message }
    render json: error, status: :unauthorized
  end
end
