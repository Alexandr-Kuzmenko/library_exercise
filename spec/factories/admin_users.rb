FactoryBot.define do
  factory :admin_user, class: AdminUser do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(8) }
    nickname { Faker::Internet.unique.username(8) }
  end
end
