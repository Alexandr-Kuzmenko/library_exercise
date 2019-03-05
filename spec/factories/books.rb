FactoryBot.define do
  factory :book, class: Book do
    name { Faker::Book.title }
    author { Faker::Book.author }
    remote_envelope_url { Faker::Internet.url('abali.ru', '/wp-content/uploads/2012/01/staraya_oblozhka_knigi.jpg') }
    description { Faker::Lorem.paragraph }
  end
end
