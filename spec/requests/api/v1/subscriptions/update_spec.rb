require 'rails_helper'

RSpec.describe 'update subscription' do
  describe 'cancel subscription' do
    let!(:teas) { create_list(:tea, 2) }
    let!(:customer) { create(:customer) }
    subscription_1 = create(:subscription, customer: customer, status: :active)
    create(:subscription_tea, subscription: subscription_1, tea: teas[0], amount: 1)

    let!(:headers) { {"CONTENT_TYPE" => "application/json"} }

    let!(:body) { { status: "cancelled"} }

    it 'cancels a customer subscription' do
        patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription_1.id}", headers: headers, params: body.to_json
        expect(response).to be_successful
        expect(response).to have_http_status(202)

        expect(subscription_1.reload.status).to eq("cancelled")

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to have_key(:data)
        expect(response_body[:data]).to be_a(Hash)
        expect(response_body[:data]).to have_key(:id)
        expect(response_body[:data]).to have_key(:type)
        expect(response_body[:data]).to have_key(:attributes)
    end
  end
end