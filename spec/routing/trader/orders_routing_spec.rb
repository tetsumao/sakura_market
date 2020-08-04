require "rails_helper"

RSpec.describe Trader::OrdersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trader/orders").to route_to("trader/orders#index")
    end

    it "routes to #show" do
      expect(get: "/trader/orders/1").to route_to("trader/orders#show", id: "1")
    end
  end
end
