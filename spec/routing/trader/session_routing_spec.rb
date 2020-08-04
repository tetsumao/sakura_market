require "rails_helper"

RSpec.describe Trader::SessionsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/trader/login").to route_to("trader/sessions#new")
    end

    it "routes to #create" do
      expect(post: "/trader/session").to route_to("trader/sessions#create")
    end

    it "routes to #destroy" do
      expect(delete: "/trader/session").to route_to("trader/sessions#destroy")
    end
  end
end
