class Scenario
  include Mongoid::Document

  field :summary, type: String
  field :details, type: String

  belongs_to :user_story

  validates_presence_of       :summary
  validates_length_of         :summary, minimum: 3, maximum: 255

  validates_length_of         :details, maximum: 4096
end
