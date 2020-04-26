require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:draft_event) { create(:event, :draft) }
  let!(:published_event) { create(:event, :published) }

  it { is_expected.to validate_inclusion_of(:category).in_array(Event::CATEGORIES) }

  describe 'published scope' do
    it 'should not include draft events' do
      expect(Event.published).not_to include(draft_event)
    end
  end
end
