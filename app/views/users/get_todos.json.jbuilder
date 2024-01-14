json.todos @current_user.todos do |todo|
  json.todo_id todo.id
  json.todo todo.todo
  json.category todo.category
end
