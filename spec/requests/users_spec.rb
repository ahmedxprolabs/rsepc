require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "GET /users" do
    it "renders index successfully" do
      get users_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(user.name)
    end
  end

  describe "GET /users/:id" do
    it "renders show successfully" do
      get user_path(user)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(user.email)
    end
  end

  describe "POST /users" do
    it "creates a user with valid params" do
      expect {
        post users_path, params: { user: { name: "John", email: "john@example.com" } }
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

  describe "PATCH /users/:id" do
    it "updates a user with valid params" do
      patch user_path(user), params: { user: { name: "Updated Name" } }
      expect(user.reload.name).to eq("Updated Name")
      expect(response).to redirect_to(user_path(user))
    end

    it "does not update a user with invalid params" do
      patch user_path(user), params: { user: { name: "" } }
      expect(user.reload.name).not_to eq("")
      expect(response.body).to include("error")
    end
  end

  describe "DELETE /users/:id" do
    it "destroys a user" do
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to(users_path)
    end
  end
end
