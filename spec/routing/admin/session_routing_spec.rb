require "rails_helper"

RSpec.describe Admin::SessionsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/admin/login").to route_to("admin/sessions#new")
    end

    it "routes to #create" do
      expect(post: "/admin/session").to route_to("admin/sessions#create")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/session").to route_to("admin/sessions#destroy")
    end
  end
end
