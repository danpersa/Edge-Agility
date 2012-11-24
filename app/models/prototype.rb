class Prototype
  include Mongoid::Document

  field :title, type: String
  field :file_name, type: String

  belongs_to :user_story
end