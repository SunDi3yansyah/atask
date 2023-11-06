require "rails_helper"

RSpec.describe App::TransfersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/app/transfers").to route_to("app/transfers#index", format: "json")
    end

    it "routes to #show" do
      expect(get: "/app/transfers/1").to route_to("app/transfers#show", id: "1", format: "json")
    end

    it "routes to #create" do
      expect(post: "/app/transfers").to route_to("app/transfers#create", format: "json")
    end
  end
end
