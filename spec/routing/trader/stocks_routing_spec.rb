require "rails_helper"

RSpec.describe Trader::StocksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trader/stocks").to route_to("trader/stocks#index")
    end

    it "routes to #new" do
      expect(get: "/trader/stocks/new").to route_to("trader/stocks#new")
    end

    it "routes to #show" do
      expect(get: "/trader/stocks/1").to route_to("trader/stocks#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/trader/stocks/1/edit").to route_to("trader/stocks#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/trader/stocks").to route_to("trader/stocks#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/trader/stocks/1").to route_to("trader/stocks#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trader/stocks/1").to route_to("trader/stocks#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trader/stocks/1").to route_to("trader/stocks#destroy", id: "1")
    end
  end
end
