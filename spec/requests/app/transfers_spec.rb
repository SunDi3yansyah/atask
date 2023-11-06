require 'rails_helper'

RSpec.describe App::TransfersController, type: :request do

  let(:user) { create(:app_user) }
  let(:from) { user }
  let(:to) { create(:app_user) }
  let!(:user_wallet) { create(:app_user_wallet, user: user, in_out: 'IN', amount: 10_000_000) }

  let!(:transfers) { create_list(:app_transfer, 3, from: from.id, to: to.id) }
  let(:transfer) { transfers.first }

  let(:valid_attributes) {
    {
      transfer: {
        to: to.id,
        amount: rand(10000..100000)
      }
    }.to_json
  }

  let(:invalid_attributes) {
    {
      transfer: {
        to: nil,
        amount: nil
      }
    }.to_json
  }

  describe 'GET #index' do
    context 'invalid headers' do
      before { get app_transfers_path, headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'success' do
      before { get app_transfers_path, headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data'].pluck('id')).to match_array(transfers.pluck('id')) }
    end
  end

  describe 'GET #show' do
    context 'invalid headers' do
      before { get app_transfer_path(transfer), headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'not found' do
      before { get app_transfer_path('wrong'), headers: user_valid_headers }

      it { expect(response).to have_http_status(404) }
    end

    context 'success' do
      before { get app_transfer_path(transfer), headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data']['description']).to eq(transfer['description']) }
    end
  end

  describe 'POST #create' do
    context 'invalid headers' do
      before { post app_transfers_path, headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'all params nil' do
      before { post app_transfers_path, headers: user_valid_headers, params: invalid_attributes }

      it { expect(response).to have_http_status(422) }
    end

    context 'success' do
      before { post app_transfers_path, headers: user_valid_headers, params: valid_attributes }

      it { expect(response).to have_http_status(201) }
    end
  end

end
