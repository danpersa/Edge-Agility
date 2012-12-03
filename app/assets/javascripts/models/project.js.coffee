EdgeAgility.Project = DS.Model.extend(
  code: DS.attr("string")
  name: DS.attr("string")
  description: DS.attr("string")
  iterations: DS.hasMany('EdgeAgility.Iteration', { embedded: true })
)
