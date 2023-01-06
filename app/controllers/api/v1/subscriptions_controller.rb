class Api::V1::SubscriptionsController < ApplicationController
    def create
      new_sub = Subscription.new(subscription_params)
      if new_sub.save
        render json: SubscriptionSerializer.new(new_sub)
      end
    end

    private

    def subscription_params
      sub_params = params.permit(:customer_id, :title, :price, :frequency, :status, teas: %i[amount tea_id])
      sub_params[:tea_subscriptions_attributes] = sub_params.delete :teas if sub_params[:teas]
      sub_params
    end
  end