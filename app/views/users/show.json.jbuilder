json.user do
  json.id @current_user.id
  json.token @current_user.token
  json.username @current_user.username
  json.email @current_user.email
  json.admin @current_user.admin
  json.todos @current_user.todos do |todo|
    json.todo_id todo.id
    json.todo todo.todo
    json.category todo.category
  end
  json.created_at @current_user.created_at
  json.updated_at @current_user.updated_at
end