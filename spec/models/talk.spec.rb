require 'rails_helper'

RSpec.describe Talk, type: :model do
  let!(:draft_talk) { create(:talk, event: build(:event, :draft)) }
  let!(:published_talk) { create(:talk, event: build(:event, :published)) }

  describe 'published scope' do
    it 'should not include draft talks' do
      expect(Talk.all).to include(draft_talk)
      expect(Talk.published).not_to include(draft_talk)
    end
  end
end
