require "rails_helper"

RSpec.describe Trader::ShippingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/trader/shippings").to route_to("trader/shippings#index")
    end

    it "routes to #new" do
      expect(get: "/trader/shippings/new").to route_to("trader/shippings#new")
    end

    it "routes to #show" do
      expect(get: "/trader/shippings/1").to route_to("trader/shippings#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/trader/shippings/1/edit").to route_to("trader/shippings#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/trader/shippings").to route_to("trader/shippings#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/trader/shippings/1").to route_to("trader/shippings#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/trader/shippings/1").to route_to("trader/shippings#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/trader/shippings/1").to route_to("trader/shippings#destroy", id: "1")
    end
  end
end
