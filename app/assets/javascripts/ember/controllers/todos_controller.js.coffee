Todos.todosController = Ember.ArrayController.create
  content: Todos.Todo.all()

  createTodo: (title) ->
    todo = Todos.Todo.create({ title: title })
    this.pushObject(todo)
    todo.save()

  clearCompletedTodos: ->
    this.filterProperty('isDone', true)
        .forEach(this.removeObject, this)

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