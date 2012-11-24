object @project
attributes :_id => :id
attributes :name, :description, :code, :user_story_seq
child :iterations do
  attributes :_id => :id
  attributes :name, :start_date, :end_date
end