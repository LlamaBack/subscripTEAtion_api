class Api::V1::SubscriptionsController < ApplicationController
    def create
      new_sub = Subscription.new(subscription_params)
      if new_sub.save
        render json: SubscriptionSerializer.new(new_sub)
      end
    end

    def index
      subscriptions = Customer.find(params[:customer_id]).subscriptions
      render json: SubscriptionSerializer.new(subscriptions)
    end

    def update
      subscription = Subscription.find(params[:id])
      subscription.update(subscription_params)
      render json: SubscriptionSerializer.new(subscription)
    end

    private

    def subscription_params
      sub_params = params.permit(:customer_id, :title, :price, :frequency, :status, teas: %i[amount tea_id])
      sub_params[:tea_subscriptions_attributes] = sub_params.delete :teas if sub_params[:teas]
      sub_params
    end
  end