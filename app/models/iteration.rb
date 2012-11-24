class Iteration
  include Mongoid::Document

  field :name, :type => String
  field :start_date, :type => Date
  field :end_date, :type => Date

  has_many :user_stories
end
