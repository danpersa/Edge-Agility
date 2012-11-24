object @technical_story
attributes :_id => :id
attributes :code, :summary, :details, :status
child :user_story do
  attributes :_id => :id
  attributes :code, :summary, :details, :order, :points
end