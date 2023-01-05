FactoryBot.define do
  factory :subscription do
    customer
    title { Faker::Subscription.plan }
    price { Faker::Number.between(from: 10, to: 50) }
    status { 1 }
    frequency { 1 }
  end
end
