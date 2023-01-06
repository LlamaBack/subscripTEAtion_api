class SubscriptionSerializer
  include JSONAPI::Serializer

  attributes :title,
             :price,
             :frequency,
             :status

  attribute :teas do |sub|
    sub.tea_subscriptions.map do |sub_tea|
      { tea_id: sub_tea.tea_id.to_s, amount: sub_tea.amount }
    end
  end

end