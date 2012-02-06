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
    self = this
    isNew = self.get('isNew')

    if isNew
      url = '/todos.json'
      method = 'POST'
    else
      url = "/todos/#{self.get('id')}.json"
      method = 'PUT'

    $.ajax url,
      type: 'POST'
      data: { todo: self.get('attributes'), _method: method }
      dataType: 'text'
      success: (data, response) ->
        data = $.trim(data)
        data = JSON.parse(data) if data
        self.set('id', data['id'])
      error: (response, status, error) ->
        console.error status, error, response.responseText
    self

  autosave: (->
    this.save()
  ).observes('isDone')
  

Todos.Todo.all = ->
  todos = []
  $.ajax '/todos.json',
      dataType: 'json'
      success: (data) ->
        data.forEach (item) ->
          todo = Todos.Todo.create
            id: item.id
            title: item.title
          todos.pushObject(todo)
      error: (response, status, error) ->
        console.error status, error, response.responseText
  todos