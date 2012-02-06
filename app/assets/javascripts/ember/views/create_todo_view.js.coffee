Todos.CreateTodoView = Ember.TextField.extend

  insertNewline: ->
    value = this.get('value');
    if value
      Todos.todosController.createTodo(value)
      this.set('value', '')