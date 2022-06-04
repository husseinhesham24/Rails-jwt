class UsersController < ApplicationController

  before_action :authorize_request, except: %i[ create ]
  before_action :set_user, except: %i[create index]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
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
    unless @user.update(user_params)
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    begin
      @user = User.find_by_username(params[:username])
    rescue ActiveRecord::RecordNotFound => e
      render json: {errors: e.message}, status: :not_found
    end
  end

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end
