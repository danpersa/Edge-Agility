EdgeAgility.UserStory = DS.Model.extend(
  primaryKey: 'id'
  id: DS.attr("string")
  summary: DS.attr("string")
  details: DS.attr("string")
  order: DS.attr("number")
  iteration: DS.belongsTo('EdgeAgility.Iteration')

  validate: ->
    if @get("summary") is `undefined` or @get("summary") is ""
      "User story require a summary"
).reopenClass(
  url: "user_story"
)