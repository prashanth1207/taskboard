module V1
  class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create, :login]

    include UserDoc
    def index
      request_scope = User.all
      total_count = request_scope.count
      users = request_scope.page(params[:page], params[:per_page])
      render json: users
    end

    def create
      if User.where(email: create_params[:email]).exists?
        return render json: { error: 'Email already exists' }, status: :unprocessable_entity
      end
      user = User.new(create_params)
      user.save!
      render json: { auth_token: user.auth_token }
    end

    def login
      user = User.find_by(email: login_params[:email])
      unless user.present? && user.verify_password(login_params[:password])
        return render json: { errors: ['Invalid email/password']} 
      end
      render json: { auth_token: user.auth_token }
    end

    private

    def create_params
      params.permit(:email, :username, :password, :password_confirmation)
    end

    def login_params
      params.permit(:email, :password)
    end
  end
end
