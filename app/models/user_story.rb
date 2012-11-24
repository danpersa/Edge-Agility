class UserStory
  include Mongoid::Document

  field :summary, :type => String
  field :details, :type => String
  field :order,   :type => Integer

  has_many :scenarios
  belongs_to :iteration

  validates_presence_of       :summary
  validates_length_of         :summary, minimum: 3, maximum: 255

  validates_length_of         :details, maximum: 4096
end
