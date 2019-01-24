module GlobalExceptionHandler
  extend ActiveSupport::Concern

  included do
    # rescue_from are evaluated from bottom to top i.e. last defined handler
    # will have the highest priority and the first defined handler will have
    # the lowest priority.
    rescue_from StandardError do |ex|
      render json: { message: ex.message }, status: :internal_server_error
    end

    rescue_from ActiveRecord::RecordNotFound do |ex|
      render json: { message: ex.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      render json: { message: ex.message }, status: :unprocessable_entity
    end
  end
end
