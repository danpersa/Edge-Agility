collection @user_stories, :root => "user_stories", :object_root => false
attributes :_id => :id
attributes :summary, :details, :order
child :iteration do
  attributes :_id => :id
  attributes :name, :start_date, :end_date
end