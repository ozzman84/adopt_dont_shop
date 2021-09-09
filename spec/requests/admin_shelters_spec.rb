require 'rails_helper'

RSpec.describe "AdminShelters", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin_shelters/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      @admin = Shelter.create
      get "/admin/shelters/#{@admin.id}"
      expect(response).to have_http_status(200)
    end
  end
end
