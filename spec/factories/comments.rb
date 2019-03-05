FactoryBot.define do
  factory :admin_comment, class: Comment do
    book
    commentator { [user, admin_user].sample.class }
    commentator_id { [user, admin_user].sample.id }
    text { Faker::Games::WorldOfWarcraft.quote }
  end

  factory :comment, class: Comment do
    book
    commentator { FactoryBot.create(:user).class }
    commentator_id { FactoryBot.create(:user).id }
    text { Faker::Games::WorldOfWarcraft.quote }
  end
end
