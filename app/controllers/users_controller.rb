class UsersController < ApplicationController
  before_action :authorize_request, except: %i[ create ]

  #for admin
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def get_todos
  end

  def show
  end

  def create
    @user = User.new(user_params_create)
    if @user.save
      render json: {
        "id": @user.id,
        "username": @user.username,
        "email": @user.email,
        "admin": @user.admin,
        "created_at": @user.created_at,
        "updated_at": @user.updated_at,
      }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    done = true
    if params[:user][:username].present?
      if @current_user.update(user_params_update_username)
      else
        done = false
        render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end
    if params[:user][:password].present?
      if @current_user.update(user_params_update_password)
      else
        done = false
        render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    if done
      render json: {
        "id": @current_user.id,
        "username": @current_user.username,
        "email": @current_user.email,
        "admin": @current_user.admin,
        "created_at": @current_user.created_at,
        "updated_at": @current_user.updated_at,
      }, status: :ok
    end
  end

  def destroy
    @current_user.destroy
    render json: {
      "message": "Deleted successfully",
    }, status: :ok
  end

  private

  def user_params_create
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def user_params_update_username
    params.require(:user).permit(:username)
  end

  def user_params_update_password
    params.require(:user).permit(:password, :password_confirmation)
  end
end
