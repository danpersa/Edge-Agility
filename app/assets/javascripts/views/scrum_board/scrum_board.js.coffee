EdgeAgility.ScrumBoardView = Ember.View.extend({
  templateName:    'scrum_board/list'

  didInsertElement: ->
    @_super()
    @$("ul.droptrue").sortable
      connectWith: "ul"
    @$("#sortable1, #sortable2, #sortable3", "#sortable4" ).disableSelection()

})