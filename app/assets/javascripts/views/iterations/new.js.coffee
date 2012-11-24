EdgeAgility.NewIterationView = Ember.View.extend({
  templateName: 'iterations/new',
  tagName: 'form',
  classNames: 'form-horizontal',

  didInsertElement: ->
    this._super()
    this.$('input:first').focus()

  submit: (event) ->
    event.preventDefault()
    this.get('controller').createRecord()
})