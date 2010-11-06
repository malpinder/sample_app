# By using the symbol ':user', we get Factory Girl to simulate the User model.
# in the tests this factory can be used like this: @user = Factory(:user)
Factory.define :user do |user|
  user.name                  "Andreas Finger"
  user.email                 "andy@mediafinger.com"
  user.password              "foobar23"
  user.password_confirmation "foobar23"
end

# create unique email addresses 'person-1..x@example.com'
# in the tests call: Factory(:user, :email => Factory.next(:email))
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

