require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should have_many :tea_subscriptions }
    it { should have_many(:teas).through :tea_subscriptions }
    it { should belong_to :customer }
  end
end
