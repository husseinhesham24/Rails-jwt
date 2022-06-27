class AuthenticationController < ApplicationController

  before_action :authorize_request, except: %i[ login ]

  def login
    @user = User.find_by_email(params[:email])
    if @user.nil?
      render json: {errors: "User is not found"}, status: :unprocessable_entity
    else
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode({user_id:@user.id})
        time = Time.now + 30.days.to_i
        @user.update(token: token)
        render json: {
          token: token,
          exp: time.strftime("%d-%m-%Y %H:%M"),
          user: {
            username: @user.username,
            email: @user.email
          },
        }, status: :ok
      else
        render json: {errors: "Password is invalid"}, status: :unprocessable_entity

      end
    end
  end

  def logout
    if @current_user.update(token: nil)
      render json: {
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {errors: @current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
