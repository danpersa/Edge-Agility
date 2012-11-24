EdgeAgility.QuickUserStoryView = Ember.View.extend({
  templateName: 'backlog/quick_user_story',
  tagName: 'form',
  classNames: 'form-horizontal',

  didInsertElement: ->
    this._super()
    this.$('input:first').focus()

  submit: (event) ->
    event.preventDefault()
    this.get('controller').createRecord()
})