class UsersController < ApplicationController

  before_action :authorize_request, except: %i[ create ]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: {
      "id": @current_user.id,
      "username": @current_user.username,
      "email": @current_user.email,
      "admin": @current_user.admin,
      "created_at": @current_user.created_at,
      "updated_at": @current_user.updated_at
    }, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        "id": @user.id,
        "username": @user.username,
        "email": @user.email,
        "admin": @user.admin,
        "created_at": @user.created_at,
        "updated_at": @user.updated_at
      }, status: :created
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    if @current_user.update(
      username: (params[:username].presence)?params[:username]:(:username),
      password: (params[:password].presence)?params[:password]:(:password_digest),
    )
      render json: {
        "id": @current_user.id,
        "username": @current_user.username,
        "email": @current_user.email,
        "admin": @current_user.admin,
        "created_at": @current_user.created_at,
        "updated_at": @current_user.updated_at
      }, status: :ok
    else
      render json: {errors: @current_user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @current_user.destroy
    render json: {
      "message":"Deleted successfully"
    }, status: :ok
  end

  private


  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
