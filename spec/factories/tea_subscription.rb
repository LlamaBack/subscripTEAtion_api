FactoryBot.define do
  factory :tea_subscription do
    tea
    subscription
    quantity { rand(1..10) }
  end
end
