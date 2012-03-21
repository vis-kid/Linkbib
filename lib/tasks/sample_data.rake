namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_links
    make_relationships
  end
end

def make_users
  99.times do |n|
    email = "example-#{n+1}@railstutorial.org"
    name = "Bob ##{n+1}"
    password  = "password"
    User.create!(
                 email:    email,
                 name: name,
                 password: password,
                 password_confirmation: password)
  end
end

def make_links
  users = User.all(limit: 6)
  50.times do |n|
    url = "http://www.example-#{n+1}.com"
    users.each { |user| user.links.create!(url: url) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end