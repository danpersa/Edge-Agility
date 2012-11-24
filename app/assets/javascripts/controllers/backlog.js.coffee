EdgeAgility.BacklogController = Ember.ArrayController.extend({
  selectedIteration: null

  resourceType: EdgeAgility.Iteration
  findAll: ->
    @set 'content', EdgeAgility.store.findAll(EdgeAgility.Iteration)
  selectIteration: (iterationId) ->
    @set 'selectedIteration', EdgeAgility.store.find(EdgeAgility.Iteration, iterationId)

})