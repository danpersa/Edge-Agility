object @scenarios
attributes :_id => :id
attributes :summary, :details
child :user_story do
  attributes :_id => :id
  attributes :code, :summary, :details, :order, :points
end