require 'rails_helper'

RSpec.describe App::WithdrawalsController, type: :request do

  let(:user) { create(:app_user) }
  let!(:user_wallet) { create(:app_user_wallet, user: user, in_out: 'IN', amount: 10_000_000) }

  let!(:withdrawals) { create_list(:app_withdrawal, 3, user: user) }
  let(:withdrawal) { withdrawals.first }

  let(:valid_attributes) {
    {
      withdrawal: {
        amount: rand(10000..100000),
        bank_name: %w[BRI BNI Mandiri BCA].sample,
        bank_account_number: rand.to_s.reverse[0..9],
        bank_account_name: Faker::Name.name
      }
    }.to_json
  }

  let(:invalid_attributes) {
    {
      transfer: {
        amount: nil,
        bank_name: nil,
        bank_account_number: nil,
        bank_account_name: nil
      }
    }.to_json
  }

  describe 'GET #index' do
    context 'invalid headers' do
      before { get app_withdrawals_path, headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'success' do
      before { get app_withdrawals_path, headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data'].pluck('id')).to match_array(withdrawals.pluck('id')) }
    end
  end

  describe 'GET #show' do
    context 'invalid headers' do
      before { get app_withdrawal_path(withdrawal), headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'not found' do
      before { get app_withdrawal_path('wrong'), headers: user_valid_headers }

      it { expect(response).to have_http_status(404) }
    end

    context 'success' do
      before { get app_withdrawal_path(withdrawal), headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data']['description']).to eq(withdrawal['description']) }
    end
  end

  describe 'POST #create' do
    context 'invalid headers' do
      before { post app_withdrawals_path, headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'all params nil' do
      before { post app_withdrawals_path, headers: user_valid_headers, params: invalid_attributes }

      it { expect(response).to have_http_status(422) }
    end

    context 'success' do
      before { post app_withdrawals_path, headers: user_valid_headers, params: valid_attributes }

      it { expect(response).to have_http_status(201) }
    end
  end

end
