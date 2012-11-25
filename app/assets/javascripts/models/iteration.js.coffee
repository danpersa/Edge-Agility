EdgeAgility.Iteration = DS.Model.extend(
  primaryKey: 'id'
  id: DS.attr("string")
  name: DS.attr("string")
  start_date: DS.attr("date")
  end_date: DS.attr("date")
  user_stories: DS.hasMany('EdgeAgility.UserStory', { embedded: true })
  project: DS.belongsTo('EdgeAgility.Project')

  validate: ->
    if @get("name") is `undefined` or @get("name") is ""
      "Iteration require a name"

  sortedUserStories: (->
    @get('user_stories').toArray().sort (a, b) ->
      a.get('order') - b.get('order')
    ).property('user_stories.@each').cacheable()
).reopenClass(
  url: "iteration"
)