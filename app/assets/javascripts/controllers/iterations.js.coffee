EdgeAgility.NewIterationController = Ember.Controller.extend({
  content: null
  enterNew: ->
    this.transaction = EdgeAgility.store.transaction();
    this.set('content', this.transaction.createRecord(EdgeAgility.Iteration, {}));
  exitNew: ->
    if (this.transaction)
      this.transaction.rollback()
      this.transaction = null
  createRecord: ->
    validationErrors = @get('content').validate()
    if validationErrors isnt `undefined`
      EdgeAgility.displayError validationErrors
    else
      # commit and then clear the transaction (so exitEditing doesn't attempt a rollback)
      selectedProject = EdgeAgility.router.get('projectsMenuController').get('selectedProject')
      this.get('content').set('project', selectedProject)
      this.transaction.commit();
      this.transaction = null;

      backlogController = EdgeAgility.router.get('backlogController')
      backlogController.set 'content', null
      EdgeAgility.router.transitionTo('backlog.index', {})
      #this.get('content').addObserver('id', this, 'showRecord')
  showRecord: ->
    EdgeAgility.router.transitionTo('backlog.index', this.get('content'))

})

