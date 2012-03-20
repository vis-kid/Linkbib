Factory.define :user do |user|
  user.sequence(:email) { |n| puts "Email ##{n}"; "new_factory_#{n}@example.com" }
  user.password               "password"
  user.password_confirmation  "password"
end