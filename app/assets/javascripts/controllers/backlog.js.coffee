EdgeAgility.BacklogController = Ember.ArrayController.extend({
  selectedIteration: null

  resourceType: EdgeAgility.Iteration
  findAll: ->
    selectedProject = EdgeAgility.router.get('projectsMenuController').get('selectedProject')
    iterations = EdgeAgility.store.findQuery(EdgeAgility.Iteration, {"project_id": selectedProject.get('id')})
    @set 'content', iterations

  selectIteration: (iterationId) ->
    @set 'selectedIteration', EdgeAgility.store.find(EdgeAgility.Iteration, iterationId)

})

EdgeAgility.QuickUserStoryController = Ember.Controller.extend({
  content: null
  enterNew: ->
    this.transaction = EdgeAgility.store.transaction();
    this.set('content', this.transaction.createRecord(EdgeAgility.UserStory, {}));

  exitNew: ->
    if (this.transaction)
      this.transaction.rollback()
      this.transaction = null
  createRecord: ->
    # TODO - validations
    validationErrors = @get('content').validate()
    if validationErrors isnt `undefined`
      EdgeAgility.displayError validationErrors
    else
      selectedProject = EdgeAgility.router.get('projectsMenuController').get('selectedProject')
      $.get('/backlog_iteration/' + selectedProject.get('id'), (data) ->
        quickUserStoryController = EdgeAgility.router.get('quickUserStoryController')
        backlogIteration = EdgeAgility.store.find(EdgeAgility.Iteration, data.iteration.id)
        quickUserStoryController.get('content').set 'iteration', backlogIteration
        # commit and then clear the transaction (so exitEditing doesn't attempt a rollback)
        quickUserStoryController.transaction.commit();
        quickUserStoryController.transaction = null;
        
        backlogController = EdgeAgility.router.get('backlogController')
        backlogController.set 'content', null
        qu = EdgeAgility.router.get('quickUserStoryController')
        EdgeAgility.router.transitionTo('backlog.index', qu.get('content'))
        #quickUserStoryController.get('content').addObserver('id', quickUserStoryController, 'showRecord')
      )
#  showRecord: ->
    #backlogController = EdgeAgility.router.get('backlogController')
    #backlogController.set 'content', null
    #EdgeAgility.router.transitionTo('backlog.index', this.get('content'))
})