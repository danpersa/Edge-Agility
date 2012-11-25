EdgeAgility.ScrumBoardController = Ember.ArrayController.extend({

  todoUserStories: null
  doingUserStories: null
  reviewingUserStories: null
  doneUserStories: null  

  resourceType: EdgeAgility.UserStory

  findAll: ->
    selectedIteration = EdgeAgility.router.get('backlogController').get('selectedIteration')
    @set 'todoUserStories', EdgeAgility.store.findQuery(EdgeAgility.UserStory, {"iteration_id": selectedIteration.get('id'), "status": 0})
    @set 'doingUserStories', EdgeAgility.store.findQuery(EdgeAgility.UserStory, {"iteration_id": selectedIteration.get('id'), "status": 1})
    @set 'reviewingUserStories', EdgeAgility.store.findQuery(EdgeAgility.UserStory, {"iteration_id": selectedIteration.get('id'), "status": 2})
    @set 'doneUserStories', EdgeAgility.store.findQuery(EdgeAgility.UserStory, {"iteration_id": selectedIteration.get('id'), "status": 3})
})