require 'rails_helper'

RSpec.describe 'view customer subscriptions' do

  it 'gets all customer subscriptions' do
    customer = create(:customer)
    teas = create_list(:tea, 3)
    subscription_1 = create(:subscription, customer: customer, status: :active)
    subscription_2 = create(:subscription, customer: customer, status: :active)
    subscription_3 = create(:subscription, customer: customer, status: :cancelled)

    create(:subscription_tea, tea: teas[0], subscription: subscription_1, quantity: 1)
    create(:subscription_tea, tea: teas[1], subscription: subscription_1, quantity: 2)
    create(:subscription_tea, tea: teas[2], subscription: subscription_2, quantity: 5)
    create(:subscription_tea, tea: teas[0], subscription: subscription_3, quantity: 1)
    create(:subscription_tea, tea: teas[1], subscription: subscription_3, quantity: 1)
    create(:subscription_tea, tea: teas[2], subscription: subscription_3, quantity: 1)

    get "/api/v1/customers/#{customer.id}/subscriptions"
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    
    expect(response_body).to have_key(:data)
    expect(response_body[:data]).to be_an(Array)

    first_sub = response_body[:data][0]

    expect(first_sub).to be_a Hash
    expect(first_sub[:id]).to be_a(String)
    expect(first_sub[:type]).to eq("subscription")
    expect(first_sub[:attributes]).to be_a(Hash)

    sub_atts = first_sub[:attributes]
    expect(sub_atts[:title]).to be_a String
    expect(sub_atts[:price]).to be_an Integer
    expect(sub_atts[:status]).to be_a String
    expect(sub_atts[:frequency]).to be_an Integer
    expect(sub_atts[:teas]).to be_an(Array)
    sub_atts[:teas].each do |tea|
      expect(tea[:tea_id]).to be_a(String)
      expect(tea[:quantity]).to be_an(Integer)
    end
  end
end
