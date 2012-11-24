EdgeAgility.EditProjectView = Ember.View.extend({
  templateName: 'projects/edit',
  tagName: 'form',
  classNames: 'form-horizontal',

  didInsertElement: ->
    this._super()
    this.$('input:first').focus()

  submit: (event) ->
    event.preventDefault()
    this.get('controller').updateRecord()
})