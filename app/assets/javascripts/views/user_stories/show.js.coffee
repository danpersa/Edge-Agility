EdgeAgility.ShowUserStoryView = Ember.View.extend({
  templateName: 'user_stories/show',
  classNames:   ['show-user-story'],
  tagName:      'tr',

  doubleClick: ->
    this.showEdit()

  showEdit: ->
    this.set('isEditing', true)

  hideEdit: ->
    this.set('isEditing', false)
  
  destroyRecord: ->
    userStory = this.get("userStory")

    userStory.destroyResource()
      .fail( ->
          EdgeAgility.displayError(e)
      )
      .done( ->
        EdgeAgility.userStoriesController.removeObject(userStory)
      );
  
});