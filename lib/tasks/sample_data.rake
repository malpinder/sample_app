require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "Example User",
                 :email => "example@railstutorial.org",
                 :password => "foobar23",
                 :password_confirmation => "foobar23"
                )
    admin = User.create!(:name => "Andreas Finger",
                         :email=> "andy@mediafinger.com",
                         :password => "Sabrina83",
                         :password_confirmation => "Sabrina83"
                )
    admin.toggle!(:admin)
    2.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "foobar23"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end

