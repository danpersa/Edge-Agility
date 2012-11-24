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

    make_iterations_with_user_stories
        
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

def make_iterations_with_user_stories
  debug "make iterations: "
  3.times do |n|
    print "."
    iteration = Iteration.create! :name => "Iteration #{n + 1}",
                      :start_date => Date.new,
                      :end_date => Date.new
    make_user_stories iteration
  end
end

def make_user_stories iteration
  debug "make user stories: "
  4.times do |n|
    print "."
    UserStory.create! :summary => "User does #{n + 1} push-ups",
                      :details => "As an User I want to do #{n + 1} push-ups " +
                                  "so I can have more muscles",
                      :order => 3 - n,
                      :iteration_id => iteration.id
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