Todos.Todo = Ember.Object.extend
  id: null
  title: null
  isDone: false

  attributes: ( ->
    {
      title: this.get('title')
      is_done: this.get('isDone')
    }
  ).property('title', 'isDone')

  isNew: (->
    !this.get('id')
  ).property('id')

  save: ->
    self  = this
    isNew = self.get('isNew')
    id    = self.get('id')

    if isNew
      url = '/todos.json'
      method = 'POST'
    else
      url = "/todos/#{id}.json"
      method = 'PUT'

    $.ajax url,
      type: 'POST'
      data: { todo: self.get('attributes'), _method: method }
      dataType: 'text'
      success: (data, response) ->
        if isNew
          data = $.trim(data)
          data = JSON.parse(data) if data
          self.set('id', data['id'])
      error: (response, status, error) ->
        console.error status, error, response.responseText
    self

  autosave: (->
    this.save()
  ).observes('isDone')

  delete: ->
    id = this.get('id')
    $.ajax "/todos/#{id}.json",
      type: 'POST'
      data:
        _method: 'DELETE'
      dataType: 'text'
    this

Todos.Todo.all = ->
  todos = []
  $.ajax '/todos.json',
      dataType: 'json'
      success: (data) ->
        data.forEach (item) ->
          todo = Todos.Todo.create
            id: item.id
            title: item.title
            isDone: item.is_done
          todos.pushObject(todo)
      error: (response, status, error) ->
        console.error status, error, response.responseText
  todos