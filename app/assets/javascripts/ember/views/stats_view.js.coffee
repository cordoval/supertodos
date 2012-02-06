Todos.StatsView = Ember.View.extend
  remainingBinding: 'Todos.todosController.remaining',

  remainingString: ( ->
    remaining = this.get('remaining')
    remaining + (if remaining == 1 then " item" else " items")
  ).property('remaining')