FactoryBot.define do
  factory :event do
    title { "Reboot" }
    venue  { "Nikoms Event Centre, Yaba" }
    description { 'to start something again or do something again, in a way that is new and interesting' }
    datetime { DateTime.now }
    category { 'TEDxYabaSalon' }

    trait :published do
      is_draft { false }
    end

    trait :draft do
      is_draft { true }
    end
  end
end
