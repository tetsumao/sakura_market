require "rails_helper"

RSpec.describe Admin::TradersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/traders").to route_to("admin/traders#index")
    end

    it "routes to #new" do
      expect(get: "/admin/traders/new").to route_to("admin/traders#new")
    end

    it "routes to #show" do
      expect(get: "/admin/traders/1").to route_to("admin/traders#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/traders/1/edit").to route_to("admin/traders#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/traders").to route_to("admin/traders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/traders/1").to route_to("admin/traders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/traders/1").to route_to("admin/traders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/traders/1").to route_to("admin/traders#destroy", id: "1")
    end
  end
end
