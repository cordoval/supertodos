Todos.todosController = Ember.ArrayController.create

  findAll: ->
    this.set('content', Todos.store.findAll(Todos.Todo))

  createTodo: (title) ->
    todo = Todos.store.createRecord(Todos.Todo, { title: title, is_done: false })
    Todos.store.commit()
    todo

  removeTodo: (todo) ->
    todo.deleteRecord()

  clearCompletedTodos: ->
    this.filterProperty('is_done', true)
        .forEach(this.removeTodo, this)

  remaining: (->
    this.filterProperty('is_done', false).get('length')
  ).property('@each.is_done')

  allAreDone: ((key, value) ->
    if value?
      this.setEach('is_done', value)
      value
    else
      !!this.get('length') && this.everyProperty('is_done', true)
  ).property('@each.is_done')
