require 'rails_helper'

RSpec.describe DynamicCopiesController, type: :request do
  let(:request_headers) { { "content-type": "application/json", "Accept": "application/json" } }
  let(:make_request) { get(request_path, params: params, headers: request_headers ) }
  let!(:dash_copy) { create(:dynamic_copy, key: 'dash_copy') }
  let!(:event_list_copy) { create(:dynamic_copy, key: 'event_list_copy') }

  describe 'list index' do
    let(:request_path) { "/dynamic_copies" }
    let(:params) { {} }
    let(:res) { JSON.parse(response.body)['copies'] }

    it 'should return all copies' do
      make_request
      expect(res.map{|b| b['key']}).to contain_exactly('event_list_copy', 'dash_copy')
    end
  end

  describe '#get_by_key' do
    let(:request_path) { "/dynamic_copies/get_by_key" }
    let(:params) { {key: key} }
    let(:res) { JSON.parse(response.body) }

    context 'when key exists' do
      let(:key) { 'dash_copy' }

      it 'should return the copy for that key' do
        make_request
        expect(res['key']).to eq(key)
      end
    end

    context 'when key does not exist' do
      let(:key) { 'something_missing' }

      it 'should return nothing' do
        make_request
        expect(res).to be_empty
      end
    end
  end
end
