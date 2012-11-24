object @user_story
attributes :_id => :id
attributes :summary, :details, :order
child :iteration do
  attributes :_id => :id
  attributes :name, :start_date, :end_date
end