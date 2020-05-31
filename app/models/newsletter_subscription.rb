class NewsletterSubscription < ApplicationRecord
  include HTTParty
  base_uri "https://us15.api.mailchimp.com/3.0"

  validates_uniqueness_of :email

  before_save :post_sub_to_mailchimp

  private
  def post_sub_to_mailchimp
    mailchimp_api_key = Rails.application.credentials.dig(:mailchimp, :api_key)
    list_id = Rails.application.credentials.dig(:mailchimp, :list_id)
    auth = { username: 'tedxyaba-web', password: mailchimp_api_key }
    body = {
      email_address: email,
      status: 'unsubscribed',
      tags: %w(TEDxYabaWeb-v2 NewsLetterSub)
    }

    res = self.class.post("/lists/#{list_id}/members", {
      basic_auth: auth,
      body: body.to_json,
      headers: { 'Content-Type' => 'application/json' }
    })

    self.email = "failed_#{self.email}" unless res.code == 200
  rescue HTTParty::Error
    self.email = "failed_#{self.email}"
  end
end
