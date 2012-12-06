EdgeAgility.ProjectView = Ember.View.extend({
  templateName: 'projects/show'
  projectBinding: 'EdgeAgility.projectController.content'
  iterationsBinding: 'EdgeAgility.projectController.iterations'

  didInsertElement: ->
    @_super()
    @$('#iterations').sortable
      cancel: ".ui-state-disabled"
      axis: "y"
      placeholder: "ui-state-highlight"
      handle: ".ui-icon"
      items: "li:not(:first-of-type)"
      update: =>
        array = $("#iterations").children().toArray().filter (e) -> e.tagName is 'LI'
        order = 0
        iteration = null
        for e in array
          if $(e).attr('type') is 'iteration'
            order = 0
            iterationId = $(e).attr('data-id')
            iteration = EdgeAgility.store.find(EdgeAgility.Iteration, iterationId)
          else
            userStory = EdgeAgility.store.find(EdgeAgility.UserStory, $(e).attr 'data-id')
            userStory.set 'order', order
            userStory.set 'iteration', iteration
            order += 1
    #@$('#iterations').disableSelection()

        EdgeAgility.store.commit()
})