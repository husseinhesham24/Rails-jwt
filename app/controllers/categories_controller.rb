class CategoriesController < ApplicationController

  before_action :authorize_request

  def index
    render json: {
      "categories":Category.all.sort
    }, status: :ok
  end

  def create
    @category = Category.new(category_params_create)
    if @category.save
      render json: {
        "category":@category
      }, status: :created
    else
      render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
    end
  end


  def update
    @category = Category.find(category_params_update[:id])
    if @category.update(category_params_update)
      render json: {
        "category":@category
      }, status: :ok
    else
      render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
    end

  rescue ActiveRecord::RecordNotFound => e
    render json:{errors: e}
  end

  def destroy
    @category = Category.find(category_params_update[:id])
    @category.destroy
    render json: {
      "message":"Deleted successfully"
    }, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json:{errors: e}
  end

  private

  def category_params_create
    params.permit(:name)
  end

  def category_params_update
    params.permit(:id, :name)
  end

end
