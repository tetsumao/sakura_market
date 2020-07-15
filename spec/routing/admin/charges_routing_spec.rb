require "rails_helper"

RSpec.describe Admin::ChargesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/charges").to route_to("admin/charges#index")
    end

    it "routes to #new" do
      expect(get: "/admin/charges/new").to route_to("admin/charges#new")
    end

    it "routes to #show" do
      expect(get: "/admin/charges/1").to route_to("admin/charges#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/charges/1/edit").to route_to("admin/charges#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/charges").to route_to("admin/charges#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/charges/1").to route_to("admin/charges#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/charges/1").to route_to("admin/charges#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/charges/1").to route_to("admin/charges#destroy", id: "1")
    end
  end
end
