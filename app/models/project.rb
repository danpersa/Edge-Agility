class Project
  include Mongoid::Document

  field :code, :type => String
  field :name, :type => String
  field :description, :type  => String
  field :user_story_seq, :type => Integer

  has_many :iterations
  has_and_belongs_to_many    :users

  validates_presence_of       :name

end
