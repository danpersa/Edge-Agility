object @user
attributes :_id => :id
attributes :name
child :projects do
  attributes :_id => :id
  attributes :name, :description
end