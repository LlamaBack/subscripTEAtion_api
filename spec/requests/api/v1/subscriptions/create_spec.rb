require 'rails_helper'

RSpec.describe 'create subscription' do
  let!(:teas) { create_list(:tea, 2) }
  let!(:customer) { create(:customer) }
  let!(:body) { {
    title: "Tea-riffic",
    price: 15,
    frequency: 1,
    teas: [
      {
        quantity: 14,
        tea_id: teas[0].id
      },
      {
        quantity: 14,
        tea_id: teas[1].id
      }
    ]
  } }

  it 'creates subscription for customer' do
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: body.to_json
    expect(response).to be_successful

    subscription1 = customer.subscriptions.last

    expect(subscription1.title).to eq(body[:title])
    expect(subscription1.price).to eq(body[:price])
    expect(subscription1.frequency).to eq(body[:frequency])
    expect(subscription1.teas).to match_array(teas)
    expect(subscription1.subscription_teas[0].quantity).to eq(body[:teas][0][:quantity])
    expect(subscription1.subscription_teas[1].quantity).to eq(body[:teas][1][:quantity])
  end
end