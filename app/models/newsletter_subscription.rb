class NewsletterSubscription < ApplicationRecord
  validates_uniqueness_of :email
end
