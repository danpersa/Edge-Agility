EdgeAgility.User = DS.Model.extend(
  name: DS.attr("string")
  projects: DS.hasMany('EdgeAgility.Project', { embedded: true })
)
