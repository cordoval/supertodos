#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates

window.Todos = Ember.Application.create()

Todos.store = DS.Store.create
  adapter: DS.RESTAdapter.create(bulkCommit: false)
