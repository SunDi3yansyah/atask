require 'rails_helper'

RSpec.describe App::Account::SignInController, type: :request do

  let(:password) { 'secure' }
  let(:user) { create(:app_user, password: password) }

  let(:additional_headers) do
    {
      'User-Agent': Faker::Internet.user_agent
    }
  end

  let(:valid_attributes) {
    {
      sign_in: {
        identity: [user.phone, user.email].sample,
        password: password
      }
    }.to_json
  }

  let(:invalid_attributes) {
    {
      sign_in: {
        identity: nil,
        password: nil
      }
    }.to_json
  }

  describe 'POST #create' do
    context 'invalid params' do
      before { post app_account_sign_in_path, params: invalid_attributes, headers: without_jwt_headers.merge(additional_headers) }

      it { expect(response).to have_http_status(422) }

      context 'Identity blank' do
        it { expect(json['data']['message']).to eq("Identity #{I18n.t('errors.messages.blank')}") }
      end

      context 'Password blank' do
        let(:invalid_attributes) {
          {
            sign_in: {
              identity: [user.phone, user.email].sample,
              password: nil
            }
          }.to_json
        }

        it { expect(json['data']['message']).to eq("Password #{I18n.t('errors.messages.blank')}") }
      end

      context 'Admin is not present' do
        let(:invalid_attributes) {
          {
            sign_in: {
              identity: ["+628#{rand(1000000000..9999999999)}", Faker::Internet.unique.email(domain: 'bintangdigitalasia.com')].sample,
              password: password
            }
          }.to_json
        }

        it { expect(json['data']['message']).to eq(I18n.t(:account_identity_does_not_exist)) }
      end

      context 'Password is not setup' do
        before {
          user.password = nil
          user.save(validate: false)
        }
        before { post app_account_sign_in_path, params: valid_attributes, headers: without_jwt_headers.merge(additional_headers) }

        it { expect(json['data']['message']).to eq(I18n.t(:account_password_does_not_exist)) }
      end

      context 'Password is invalid' do
        let(:invalid_attributes) {
          {
            sign_in: {
              identity: [user.phone, user.email].sample,
              password: 'wrong'
            }
          }.to_json
        }

        it { expect(json['data']['message']).to eq(I18n.t(:account_password_is_invalid)) }
      end
    end

    context 'valid params' do
      before { post app_account_sign_in_path, params: valid_attributes, headers: without_jwt_headers.merge(additional_headers) }

      it { expect(response).to have_http_status(200) }
      it { expect(json['data']['message']).to eq(I18n.t(:account_successfully_logged_in)) }
      it { expect(json['data']['token']).to eq(user.user_tokens.last.token) }

      context 'should have 2 token (new device)' do
        let!(:user_token) { create(:app_user_token, user: user) }

        it { expect(user.user_tokens.size).to eq(2) }
      end
    end
  end

end
