require 'rails_helper'

RSpec.describe App::UserWalletsController, type: :request do

  let(:user) { create(:app_user) }

  let!(:user_wallets) { create_list(:app_user_wallet, 3, user: user, in_out: 'IN') }
  let(:user_wallet) { user_wallets.first }

  describe 'GET #index' do
    context 'invalid headers' do
      before { get app_user_wallets_path, headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'success' do
      before { get app_user_wallets_path, headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data'].pluck('id')).to match_array(user_wallets.pluck('id')) }
    end
  end

  describe 'GET #show' do
    context 'invalid headers' do
      before { get app_user_wallet_path(user_wallet), headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'not found' do
      before { get app_user_wallet_path('wrong'), headers: user_valid_headers }

      it { expect(response).to have_http_status(404) }
    end

    context 'success' do
      before { get app_user_wallet_path(user_wallet), headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data']['description']).to eq(user_wallet['description']) }
    end
  end

end
