class NewsletterSubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def index
    @newsletter_subscriptions = NewsletterSubscription.all
  end

  # POST /newsletter_subscriptions
  # POST /newsletter_subscriptions.json
  def create
    @newsletter_subscription = NewsletterSubscription.new(newsletter_subscription_params)
    @newsletter_subscription.save

    respond_to do |format|
      format.json { render json: 'success', status: :created }
    end
  end

  private
  # Only allow a list of trusted parameters through.
  def newsletter_subscription_params
    params.permit(:email)
  end
end
