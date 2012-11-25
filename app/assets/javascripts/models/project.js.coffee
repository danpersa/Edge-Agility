EdgeAgility.Project = DS.Model.extend(
  primaryKey: 'id'
  id: DS.attr("string")
  code: DS.attr("string")
  name: DS.attr("string")
  description: DS.attr("string")
  iterations: DS.hasMany('EdgeAgility.Iteration', { embedded: true })
)
