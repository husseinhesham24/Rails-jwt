class TodosController < ApplicationController
  before_action :authorize_request

  def create
    @todo = Todo.new(todo_params_create)
    @todo.user = @current_user

    if @todo.save
      render json: {
        "id": @todo.id,
        "todo": @todo.todo,
        "status": @todo.status,
        "user_id":@todo.user.id,
        "category_id":@todo.category.id,
        "created_at": @todo.created_at,
        "updated_at": @todo.updated_at
      }, status: :created
    else
      render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def todo_params_create
    params.permit(:todo, :category_id)
  end
end
