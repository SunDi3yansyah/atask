require "rails_helper"

RSpec.describe App::UsersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/app/users").to route_to("app/users#index", format: "json")
    end

    it "routes to #show" do
      expect(get: "/app/users/1").to route_to("app/users#show", id: "1", format: "json")
    end
  end
end
