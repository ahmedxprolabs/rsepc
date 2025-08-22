require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "renders index successfully" do
      create_list(:user, 2)
      get users_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(User.first.name)
    end
  end

  describe "POST /users" do
    it "creates a user with valid params" do
      expect {
        post users_path, params: { user: { name: "Alice", email: "alice@example.com" } }
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(user_path(User.last))
    end

    it "does not create a user with invalid params" do
      expect {
        post users_path, params: { user: { name: "", email: "" } }
      }.not_to change(User, :count)

      expect(response.body).to include("error")
    end
  end
end
