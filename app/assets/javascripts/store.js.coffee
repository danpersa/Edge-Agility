EdgeAgility.store = DS.Store.create({
  adapter: DS.RESTAdapter.create(
    bulkCommit: false
    mappings: {
      user_stories: EdgeAgility.UserStory
      iterations: EdgeAgility.Iteration
    }
    plurals: {
      "user_story": "user_stories"
    }
  )
  revision: 4
});