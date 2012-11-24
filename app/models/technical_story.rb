class TechnicalStory
  include Mongoid::Document

  field :code,    :type => String
  field :status,  :type => Integer
  field :summary, :type => String
  field :details, :type => String 
    
  belongs_to :user_story
  
end
