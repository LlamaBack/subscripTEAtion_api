class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  enum status: %i[cancelled active]

  accepts_nested_attributes_for :tea_subscriptions

end
