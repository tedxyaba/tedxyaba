require 'rails_helper'

RSpec.describe NewsletterSubscriptionsController, type: :request do
  let(:request_path) { "/events" }
  let(:request_headers) { { "content-type": "application/json", "Accept": "application/json" } }
  let(:request_path) { "/newsletter_subscriptions" }

  it 'works' do
    expect{
      post(request_path, params: {email: 'new@sub.sc'}.to_json, headers: request_headers )
      expect(response.status).to eq(201)
    }.to change{ NewsletterSubscription.count }.by(1)
  end

  it 'returns errors when sub exists' do
    NewsletterSubscription.create(email: 'new@sub.sc')
    expect{
      post(request_path, params: {email: 'new@sub.sc'}.to_json, headers: request_headers )
      expect(response.status).to eq(422)
      res = JSON.parse(response.body)
      expect(res).to include("Email has already been taken")
    }.not_to change{ NewsletterSubscription.count }
  end

  it 'only attempts posting to mailchimp when request comes from prod' do
    host! 'tedxyaba.com'
    expect_any_instance_of(NewsletterSubscription).to receive(:post_sub_to_mailchimp)
    post(request_path, params: {email: 'news@sub.sc'}.to_json, headers: request_headers )
  end

  it 'does not attemp posting to mailchimp' do
    expect_any_instance_of(NewsletterSubscription).not_to receive(:post_sub_to_mailchimp)
    post(request_path, params: {email: 'new@sub.sc'}.to_json, headers: request_headers )
  end
end
