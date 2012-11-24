class User
  include Mongoid::Document
  field :name, :type => String
  field :uid, :type => String
  field :provider, :type => String

  has_and_belongs_to_many    :projects

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end
  
  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["nickname"]
    end
  end

  def join project
    User.where(:_id => self.id)
        .find_and_modify(:$addToSet => {:project_ids => project.id})
    Project.where(:_id => project.id)
        .find_and_modify(:$addToSet => {:user_ids => self.id})
  end
end
