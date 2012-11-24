object @project
attributes :_id => :id
attributes :name, :description
child :iterations do
  attributes :_id => :id
  attributes :name, :start_date, :end_date
end