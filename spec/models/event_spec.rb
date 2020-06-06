require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:draft_event) { create(:event, :draft) }
  let!(:published_event) { create(:event, :published) }

  it { is_expected.to validate_inclusion_of(:category).in_array(Event::CATEGORIES) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_uniqueness_of(:slug) }

  describe 'published scope' do
    it 'should not include draft events' do
      expect(Event.published).not_to include(draft_event)
    end
  end

  describe 'past? and future?' do
    it 'reflects relativity of event time to current time' do
      draft_event.datetime = 1.minutes.ago
      expect(draft_event.past?).to be_truthy
      expect(draft_event.future?).to be_falsey

      draft_event.datetime = 1.minute.from_now
      expect(draft_event.past?).to be_falsey
      expect(draft_event.future?).to be_truthy
    end
  end
end
