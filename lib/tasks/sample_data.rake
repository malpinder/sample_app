require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    user1 = User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar23",
                 :password_confirmation => "foobar23")
    30.times do
      user1.microposts.create!(:content => "A"*50)
    end
    admin = User.create!(:name => "Andreas Finger",
                         :email=> "andy@mediafinger.com",
                         :password => "Sabrina83",
                         :password_confirmation => "Sabrina83")
    admin.microposts.create!(:content => "I am admin. Any questions?")
    admin.toggle!(:admin)
    2.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "foobar23"
      user = User.create!(:name => name,
                          :email => email,
                          :password => password,
                          :password_confirmation => password)
      user.microposts.create!(:content => "Some non-relevant blind-text of #{name} to fill this space.")
      user.microposts.create!(:content => "#{name} goes on brabelling about #{name} and nothingness.")
      user.microposts.create!(:content => "#{email} is the fake email of #{name}.")
    end
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create!(:content => Faker::Lorem.sentence(5))
      end
    end
  end
end

