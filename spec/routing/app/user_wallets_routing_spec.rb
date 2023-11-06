require "rails_helper"

RSpec.describe App::UserWalletsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/app/user-wallets").to route_to("app/user_wallets#index", format: "json")
    end

    it "routes to #show" do
      expect(get: "/app/user-wallets/1").to route_to("app/user_wallets#show", id: "1", format: "json")
    end
  end
end
