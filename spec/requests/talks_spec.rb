require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let!(:draft_talk) { create(:talk, event: build(:event, :draft)) }
  let!(:published_talk) { create(:talk, event: build(:event, :published)) }
  let(:request_path) { "/talks" }
  let(:request_headers) { { "content-type": "application/json", "Accept": "application/json" } }
  let(:filter_params) { {} }
  let(:make_request) { get(request_path, params: {filters: filter_params}, headers: request_headers ) }
  let(:res) { JSON.parse(response.body) }

  describe 'listing talks' do
    it 'only return published talks' do
      make_request
      expect(res.size).to eq(1)
      expect(res.map{|b| b['topic']}).to contain_exactly(published_talk.topic)
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
      let(:request_path) { "/talks?include_drafts=true" }

      it 'works' do
        make_request
        expect(res.size).to eq(2)
        expect(res.map{|b| b['topic']}).to contain_exactly(published_talk.topic, draft_talk.topic)
      end
    end

    describe 'filtering by year' do
      let(:filter_params) { { event_year: '2020' } }

      context 'when event year matches' do
        before { published_talk.update(date: DateTime.new(2020)) }
        it_behaves_like 'response with data'
      end

      context 'when event year does not match' do
        before { published_talk.update(date: DateTime.new(2010)) }
        it_behaves_like 'response with no data'
      end
    end

    describe 'filtering by topic' do
      let(:filter_params) { { query: 'strap' } }

      context 'filter matches' do
        before { published_talk.update(topic: 'Bootstraping') }
        it_behaves_like 'response with data'
      end

      context 'filter does not match' do
        before { published_talk.update(topic: 'something else') }
        it_behaves_like 'response with no data'
      end
    end

    describe 'filtering by speaker' do
      let(:speaker) { published_talk.speaker }
      let(:filter_params) { { query: 'John' } }

      context 'filter matches' do
        before { speaker.update(name: 'Johnson Rake') }
        it_behaves_like 'response with data'
      end

      context 'filter does not match' do
        before { speaker.update(name: 'something else') }
        it_behaves_like 'response with no data'
      end
    end

    describe 'filtering by category' do
      let(:event) { published_talk.event }
      let(:filter_params) { { category: 'TEDxYabaWomen' } }

      context 'filter matches' do
        before { event.update(category: 'TEDxYabaWomen') }
        it_behaves_like 'response with data'
      end

      context 'filter does not match' do
        before { event.update(category: 'TEDxYabaTeen') }
        it_behaves_like 'response with no data'
      end
    end

    describe 'filtering by event' do
      let(:event) { published_talk.event }

      context 'filter matches' do
        let(:filter_params) { { event: event.id } }
        it_behaves_like 'response with data'
      end

      context 'filter does not match' do
        let(:filter_params) { { event: event.id+99 } }
        it_behaves_like 'response with no data'
      end
    end

    describe 'pagination' do
      let(:filter_params) { { per_page: '2' } }
      let!(:talk_2) { create(:talk) }
      let!(:talk_3) { create(:talk) }
      let!(:talk_4) { create(:talk) }
      let!(:talk_5) { create(:talk) }

      it 'defaults page to 0' do
        make_request
        expect(res.size).to eq(2)
        expect(res[0]['id']).to eq(talk_5.id)
        expect(res[1]['id']).to eq(talk_4.id)
      end

      context 'with page specified' do
        let(:filter_params) { { per_page: '2', page_count: 1 } }

        it 'fetches the right page' do
          make_request
          expect(res.size).to eq(2)
          expect(res[0]['id']).to eq(talk_3.id)
          expect(res[1]['id']).to eq(talk_2.id)
        end
      end
    end
  end
end
