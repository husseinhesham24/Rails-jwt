class TodosController < ApplicationController
  before_action :authorize_request


  def create
    @todo = Todo.new(todo_params_create)
    @todo.user = @current_user
    debugger
    if @todo.save
      render json: {
        "id": @todo.id,
        "todo": @todo.todo,
        "status": @todo.status,
        "user_id":@todo.user.id,
        "category":@todo.category,
        "created_at": @todo.created_at,
        "updated_at": @todo.updated_at
      }, status: :created
    else
      render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @todo = Todo.find(todo_params[:id])
    done = true
    if @todo.user_id==@current_user.id && params[:todo].present?
      if @todo.update(todo_params_update_todo)
      else
        done = false
        render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
      end
    end
    if params[:status].present?
      if @todo.update(todo_params_update_status)
      else
        done = false
        render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
      end
    end

    if params[:category_id].present?
      if @todo.update(todo_params_update_category)
      else
        done = false
        render json: {errors: @todo.errors.full_messages}, status: :unprocessable_entity
      end
    end

    if done
      render json: {
        "todo":@todo
      }, status: :ok
    end

  rescue ActiveRecord::RecordNotFound
    render json:{errors: "Todo is not exist"}, status: :not_found
  end

  def destroy
    @todo = Todo.find(todo_params[:id])
    if @todo.user_id==@current_user.id
      @todo.destroy
      render json: {
        "message":"Deleted successfully"
      }, status: :ok
    else
      render json: {
        "message":"ya hacker mesh ana ely yat3ml m3ah el7rkat de"
      }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json:{errors: "Todo is not exist"}, status: :not_found
  end

  private

  def todo_params_create
    params.permit(:todo, :category_id)
  end

  def todo_params
    params.permit(:id)
  end

  def todo_params_update_todo
    params.permit(:todo)
  end

  def todo_params_update_status
    params.permit(:status)
  end

  def todo_params_update_category
    params.permit(:category_id)
  end
end
