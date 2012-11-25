EdgeAgility.LoginMenuController = Ember.Controller.extend({
  content: null
  logged:( ->
    if (this.get('content') != null)
      return true
    return false
  ).property('content')

  enter: ->
    $.get('/current_user', (data) ->
      current_user = EdgeAgility.store.find(EdgeAgility.User, data.user.id)
      EdgeAgility.router.get('loginMenuController').set 'content', current_user
    )
})

EdgeAgility.ProjectsMenuController = Ember.ArrayController.extend({
  selectedProject: null
  resourceType: EdgeAgility.Project

  findAll: ->
    @set 'content', EdgeAgility.store.findAll(EdgeAgility.Project)

  selectProject: (projectId) ->
    @set 'selectedProject', EdgeAgility.store.find(EdgeAgility.Project, projectId)

})

EdgeAgility.ProjectMenuController = Ember.Controller.extend({
  content: null

  enter: ->
    @set 'content', null
})

EdgeAgility.BacklogMenuController = Ember.Controller.extend({
  content: null

  enter: ->
    @set 'content', null
})

EdgeAgility.ScrumBoardMenuController = Ember.Controller.extend({
  content: null

  enter: ->
    @set 'content', null
})