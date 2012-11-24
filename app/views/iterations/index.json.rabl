collection @iterations, :root => "iterations", :object_root => false
attributes :_id => :id
attributes :name, :start_date, :end_date
child :user_stories do
  attributes :_id => :id
  attributes :summary, :details, :order
end