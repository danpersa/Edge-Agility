require 'faker'
# require 'mongo'

namespace :db do
  desc "Fill database with sample data "
  task :populate => :environment do
    Mongoid.logger.level = Logger::INFO
    Moped.logger.level = Logger::INFO

    print ::Rails.env
    Mongoid.purge!
    beginning_time = Time.now

    @user = make_user
    make_projects
        
    end_time = Time.now
    debug "Time elapsed #{(end_time - beginning_time)} seconds"
    puts
  end
end

def debug message
  puts
  print message
  Rails.logger.info message
end

def make_user
  User.create! :name => "danpersa",
               :uid => "579158",
               :provider => "github"
end

def make_projects
  debug "maje_projects"
  3.times do |n|
    print "."
    project = Project.create! :name => "Project #{n + 1}",
                              :description => "Making an agile board",
                              :code => "PR #{n}",
                              :user_story_seq => 1
    make_iterations_with_user_stories project
  end
  @user.join Project.all.first
end

def make_iterations_with_user_stories project
  debug "make iterations: "
  3.times do |n|
    print "."
    iteration = Iteration.create! :name => "Iteration #{n + 1}",
                      :start_date => Date.new,
                      :end_date => Date.new,
                      :project_id => project.id
    make_user_stories iteration
  end
end

def make_user_stories iteration
  debug "make user stories: "
  4.times do |n|
    print "."
    user_story = UserStory.create! :summary => "User does #{n + 1} push-ups",
                      :details => "As an User I want to do #{n + 1} push-ups " +
                                  "so I can have more muscles",
                      :points => n,
                      :code => "US-#{iteration.project.code}-#{n+1}",
                      :order => 3 - n,
                      :status => 0,                      
                      :iteration_id => iteration.id
    make_technical_stories user_story
    make_scenarios user_story
    make_prototypes user_story
  end
  puts
end

def make_technical_stories user_story
  debug "make technical stories: "
  4.times do |n|
    print "."
    TechnicalStory.create! :summary => "System supports #{n + 1} types of logging",
                      :details => "Method to do exception handling",
                      :points => n,
                      :code => "TS-#{user_story.iteration.project.code}-#{n+1}",                     
                      :status => 0,                      
                      :user_story_id => user_story.id
  end
  puts
end

def make_scenarios user_story
  debug "make scenarios: "
  4.times do |n|
    print "."
    Scenario.create! :summary => "Scenario #{n}",
                      :details => "First you need to do this and that",                        
                      :user_story_id => user_story.id
  end
  puts
end

def make_prototypes user_story
  debug "make prototypes: "
  4.times do |n|
    print "."
    Prototype.create! :title => "Prototype #{n}",
                      :file_name => "/path/prototype.jpg",                        
                      :user_story_id => user_story.id
  end
  puts
end

def make_users
  debug "make users: "
  admin = User.create!(:username => "ExampleUser",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.admin = true
  print "."
  admin.save!
  admin.activate!
  print "."
  49.times do |n|
    print "."
    username = Faker::Name.name[0, 25]
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    user = User.create!(:username => username,
                        :email => email,
                        :password => password,
                        :password_confirmation => password)
    user.activate!
  end
  return admin
end

def make_relationships(admin)
  debug "make relationships: "
  users = User.all.limit 10
  user = admin
  following = users[3..10]
  followers = users[3..5]
  debug "    admin follows other users: "
  following.each { |followed| user.follow!(followed); print "."; }
  debug "    other users follow admin: "
  followers.each { |follower| follower.follow!(user); print "." }
  other_user = users[4]
  debug "    another user follow some users: "
  followers.each { |follower| follower.follow!(other_user); print "." }
  debug "    some users follow another user: "
  following.each { |followed| other_user.follow!(followed); print "." }
end