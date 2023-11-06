require "rails_helper"

RSpec.describe App::WithdrawalsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/app/withdrawals").to route_to("app/withdrawals#index", format: "json")
    end

    it "routes to #show" do
      expect(get: "/app/withdrawals/1").to route_to("app/withdrawals#show", id: "1", format: "json")
    end

    it "routes to #create" do
      expect(post: "/app/withdrawals").to route_to("app/withdrawals#create", format: "json")
    end
  end
end
