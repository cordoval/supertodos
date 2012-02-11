Todos.StatsView = Ember.View.extend
  remainingCloneBinding: 'Todos.todosController.remaining'

  remainingString: ( ->
    result = this.get('remainingClone')
    result + (if result == 1 then " item" else " items")
  ).property('remainingClone')