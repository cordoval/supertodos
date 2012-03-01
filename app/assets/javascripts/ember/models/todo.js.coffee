Todos.Todo = DS.Model.extend
  title: DS.attr('string')
  is_done: DS.attr('boolean')

  attributes: ( ->
    {
      title: this.get('title')
      is_done: this.get('is_done')
    }
  ).property('title', 'is_done')

  isNew: (->
    !this.get('id')
  ).property('id')

  autosave: (->
    Todos.store.commit()
  ).observes('is_done')
