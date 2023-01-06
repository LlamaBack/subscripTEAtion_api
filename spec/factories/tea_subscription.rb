FactoryBot.define do
  factory :tea_subscription do
    tea
    subscription
    amount { rand(1..10) }
  end
end
