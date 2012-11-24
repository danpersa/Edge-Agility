EdgeAgility.EditUserStoryView = Ember.View.extend({
  templateName: 'user_stories/edit',
  tagName: 'form',
  classNames: 'form-horizontal',

  didInsertElement: ->
    this._super()
    this.$('input:first').focus()

  submit: (event) ->
    event.preventDefault()
    this.get('controller').updateRecord()
})