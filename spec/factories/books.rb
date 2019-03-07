FactoryBot.define do
  factory :book, class: Book do
    name { Faker::Book.unique.title }
    author { Faker::Book.author }
    remote_envelope_url { Faker::Internet.url('abali.ru', '/wp-content/uploads/2012/01/staraya_oblozhka_knigi.jpg') }
    description { Faker::Lorem.paragraph }

    # factory :commented_book, class: Book do
    #   after(:create) do |book, evaluator|
    #     comments_count ||= 0
    #     evaluator.comments_count.times do
    #       book.comments.create(attributes_for(:comment))
    #     end
    #   end
    # end
  end
end
