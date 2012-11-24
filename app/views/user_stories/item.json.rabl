object @user_story
attributes :_id => :id
attributes :code, :summary, :details, :order, :points, :status
child :iteration do
  attributes :_id => :id
  attributes :name, :start_date, :end_date
end
child :technical_stories do
  attributes :_id => :id
  attributes :code, :status, :summary, :details
end