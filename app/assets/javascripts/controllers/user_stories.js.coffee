EdgeAgility.UserStoriesController = Ember.ArrayController.extend({
  selectedUserStory: null

  resourceType: EdgeAgility.UserStory
  findAll: ->
    @set 'content', EdgeAgility.store.findAll(EdgeAgility.UserStory)
  selectUserStory: (userStoryId) ->
    @set 'selectedUserStory', EdgeAgility.store.find(EdgeAgility.UserStory, userStoryId)

})

EdgeAgility.NewUserStoryController = Ember.Controller.extend({
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
      # commit and then clear the transaction (so exitEditing doesn't attempt a rollback)
      this.transaction.commit();
      this.transaction = null;
      this.get('content').addObserver('id', this, 'showRecord')
  showRecord: ->
    EdgeAgility.router.transitionTo('userStories.index', this.get('content'))
})

EdgeAgility.EditUserStoryController = Ember.Controller.extend({
  content: null

  enterEdit: ->
    this.transaction = EdgeAgility.store.transaction()
    this.transaction.add(this.get('content'))

  exitEdit: ->
    if (this.transaction)
      this.transaction.rollback()
      this.transaction = null

  updateRecord: ->
    # TODO - validations

    # commit and then clear the transaction (so exitEditing doesn't attempt a rollback)
    this.transaction.commit()
    this.transaction = null
    # when updating records, the id is already known, so we can transition immediately
    this.showRecord();

  showRecord: ->
    EdgeAgility.router.transitionTo('userStories.index', this.get('content'));

})

EdgeAgility.DestroyUserStoryController = Em.Controller.extend({
  content: null

  destroyRecord: ->
    this.get('content').deleteRecord()
    this.get('store').commit()

})
