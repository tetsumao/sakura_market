require "rails_helper"

RSpec.describe Admin::DeliveryPeriodsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/delivery_periods").to route_to("admin/delivery_periods#index")
    end

    it "routes to #new" do
      expect(get: "/admin/delivery_periods/new").to route_to("admin/delivery_periods#new")
    end

    it "routes to #show" do
      expect(get: "/admin/delivery_periods/1").to route_to("admin/delivery_periods#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/delivery_periods/1/edit").to route_to("admin/delivery_periods#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/delivery_periods").to route_to("admin/delivery_periods#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/delivery_periods/1").to route_to("admin/delivery_periods#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/delivery_periods/1").to route_to("admin/delivery_periods#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/delivery_periods/1").to route_to("admin/delivery_periods#destroy", id: "1")
    end
  end
end
