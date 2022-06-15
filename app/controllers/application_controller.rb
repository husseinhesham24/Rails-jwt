class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decode = JsonWebToken.decode(header)
      @current_user = User.find(@decode[:user_id])

      if @current_user.token.nil? || @current_user[:token]!=header
        render json: {errors: "unauthorized"}, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: e.message}, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: {errors: e.message}, status: :unauthorized
    end
  end
end
