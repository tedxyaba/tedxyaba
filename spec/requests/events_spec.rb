require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let!(:draft_event) { create(:event, :draft) }
  let!(:published_event) { create(:event, :published) }
  let(:request_path) { "/events" }
  let(:request_headers) { { "content-type": "application/json", "Accept": "application/json" } }
  let(:filter_params) { {} }
  let(:make_request) { get(request_path, params: {filters: filter_params}, headers: request_headers ) }
  let(:res) { JSON.parse(response.body) }

  describe 'list index' do
    it 'only return published events' do
      make_request
      expect(res.map{|b| b['id']}).to contain_exactly(published_event.id)
    end

    shared_examples 'response with data' do
      it 'works' do
        make_request
        expect(res).not_to be_empty
      end
    end

    shared_examples 'response with no data' do
      it 'works' do
        make_request
        expect(res).to be_empty
      end
    end

    context 'requesting drafts too' do
      let(:filter_params) { { include_draft: true } }

      it 'works' do
        make_request
        expect(res.map{|b| b['id']}).to contain_exactly(published_event.id, draft_event.id)
      end
    end

    describe 'filtering by year' do
      let(:filter_params) { { event_year: '2020' } }

      context 'when event year matches' do
        before { published_event.update(datetime: DateTime.new(2020)) }
        it_behaves_like 'response with data'
      end

      context 'when event year does not match' do
        before { published_event.update(datetime: DateTime.new(2010)) }
        it_behaves_like 'response with no data'
      end
    end

    describe 'filtering by title' do
      let(:filter_params) { { event_title: 'strap' } }

      context 'filter matches' do
        before { published_event.update(title: 'Bootstraping') }
        it_behaves_like 'response with data'
      end

      context 'filter does not match' do
        before { published_event.update(title: 'something else') }
        it_behaves_like 'response with no data'
      end
    end

    describe 'filtering by category' do
      let(:filter_params) { { category: 'TEDxYabaWomen' } }

      context 'filter matches' do
        before { published_event.update(category: 'TEDxYabaWomen') }
        it_behaves_like 'response with data'
      end

      context 'filter does not match' do
        before { published_event.update(category: 'TEDxYabaTeen') }
        it_behaves_like 'response with no data'
      end
    end
  end

  describe 'show details' do
    let(:request_path) { "/events/#{published_event.id}" }

    before { create(:talk, event: published_event) }

    it 'should contain talk(with speaker) details' do
      make_request
      expect(res['talks']).not_to be_empty
      expect(res['talks'][0]['speaker_name']).to eq('Mira Mitha')
    end
  end
end
