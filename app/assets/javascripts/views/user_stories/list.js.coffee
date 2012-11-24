EdgeAgility.UserStoriesView = Ember.View.extend({
  templateName:    'user_stories/list'
  userStoriesBinding: 'EdgeAgility.userStoriesController.content'

  showNew: ->
    this.set('isNewVisible', true)
  
  hideNew: ->
    this.set('isNewVisible', false)
  
  refreshListing: ->
    EdgeAgility.userStoriesController.findAll()

  didInsertElement: ->
    @_super()
    @$('#user-stories').sortable
      update: =>
        array = $("#user-stories").children().toArray().filter (e) -> e.tagName is 'TR'
        
});