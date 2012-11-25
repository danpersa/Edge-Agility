EdgeAgility.EditProjectController = Ember.Controller.extend({
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
    EdgeAgility.router.transitionTo('root.index', this.get('content'));

})

EdgeAgility.NewProjectController = Ember.Controller.extend({
  content: null
  enterNew: ->
    this.transaction = EdgeAgility.store.transaction();
    this.set('content', this.transaction.createRecord(EdgeAgility.Project, {}));
  exitNew: ->
    if (this.transaction)
      this.transaction.rollback()
      this.transaction = null
  createRecord: ->
    # TODO - validations
    # commit and then clear the transaction (so exitEditing doesn't attempt a rollback)
    this.transaction.commit()
    this.transaction = null
    this.get('content').addObserver('id', this, 'showRecord')
  showRecord: ->
    EdgeAgility.router.transitionTo('root.index', this.get('content'))
})