FactoryBot.define do
  factory :user, class: User do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
    nickname { Faker::Internet.unique.username(8) }
  end
end
