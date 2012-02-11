Todos.todosController = Ember.ArrayController.create
  content: []

  createTodo: (title) ->
    todo = Todos.Todo.create({ title: title })
    todo.save()
    todo

  removeTodo: (todo) ->
    todo.delete()

  clearCompletedTodos: ->
    this.filterProperty('isDone', true)
        .forEach(this.removeTodo, this)

  remaining: (->
    this.filterProperty('isDone', false).get('length')
  ).property('@each.isDone')

  allAreDone: ((key, value) ->
    if value?
      this.setEach('isDone', value)
      value
    else
      !!this.get('length') && this.everyProperty('isDone', true)
  ).property('@each.isDone')