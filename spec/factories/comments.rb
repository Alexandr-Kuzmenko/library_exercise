FactoryBot.define do
  factory :comment, class: Comment do
    book
    commentator { 'User' }
    commentator_id { FactoryBot.create(:user).id }
    text { Faker::Games::WorldOfWarcraft.quote }

    factory :admin_comment do
      commentator { 'AdminUser' }
      commentator_id { FactoryBot.create(:admin).id }
    end
  end
end
