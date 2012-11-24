EdgeAgility.User = DS.Model.extend(
  primaryKey: 'id'
  id: DS.attr("string")
  name: DS.attr("string")
  projects: DS.hasMany('EdgeAgility.Project', { embedded: true })
)
