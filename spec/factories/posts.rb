FactoryBot.define do
  factory :post do
    association :user
    title { Faker::Book.title }
    body  { Faker::Lorem.paragraph }
  end
end
