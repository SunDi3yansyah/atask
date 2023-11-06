require 'rails_helper'

RSpec.describe App::UsersController, type: :request do

  let(:user) { create(:app_user) }

  let!(:users) { create_list(:app_user, 3) }
  let(:user) { users.first }

  describe 'GET #index' do
    context 'invalid headers' do
      before { get app_users_path, headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'success' do
      before { get app_users_path, headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data'].pluck('id')).to match_array(users.pluck('id')) }
    end
  end

  describe 'GET #show' do
    context 'invalid headers' do
      before { get app_user_path(user), headers: without_jwt_headers }

      it { expect(response).to have_http_status(401) }
    end

    context 'not found' do
      before { get app_user_path('wrong'), headers: user_valid_headers }

      it { expect(response).to have_http_status(404) }
    end

    context 'success' do
      before { get app_user_path(user), headers: user_valid_headers }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data']['name']).to eq(user['name']) }
    end
  end

end
