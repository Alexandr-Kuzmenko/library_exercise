FactoryBot.define do
  factory :like, class: Like do
    book
    user_id { FactoryBot.create(:user).id }
    # association :user_id, { factory: :user }
  end
end
