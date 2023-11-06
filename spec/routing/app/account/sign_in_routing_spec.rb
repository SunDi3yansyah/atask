require 'rails_helper'

RSpec.describe 'App::Account::SignInController', type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: "/app/account/sign-in").to route_to("app/account/sign_in#create", format: "json")
    end
  end
end
