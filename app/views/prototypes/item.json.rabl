object @prototype
attributes :_id => :id
attributes :title, :file_name
child :user_story do
  attributes :_id => :id
  attributes :code, :summary, :details, :order, :points
end