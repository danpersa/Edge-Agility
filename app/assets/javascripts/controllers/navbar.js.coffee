EdgeAgility.LoginMenuController = Ember.Controller.extend({
  content: null

  enter: ->
    $.get('/current_user', (data) ->
      current_user = EdgeAgility.store.find(EdgeAgility.User, data.user.id)
      EdgeAgility.router.get('loginMenuController').set 'content', data.user
    )

})