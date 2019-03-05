FactoryBot.define do
  factory :like, class: Like do
    book
    user_id { FactoryBot.create(:user).id }
  end
end
