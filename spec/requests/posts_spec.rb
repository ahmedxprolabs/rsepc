require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let!(:post_record) { create(:post, user: user) } # existing post for show/update/destroy

  describe "GET /posts" do
    it "renders index successfully" do
      get posts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /posts/:id" do
    it "renders show successfully" do
      get post_path(post_record)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(post_record.title)
    end
  end

  describe "POST /posts" do
    it "creates a post with valid params" do
      expect {
        post posts_path, params: { post: { user_id: user.id, title: "New Post", body: "Hello" } }
      }.to change(Post, :count).by(1)

      expect(response).to redirect_to(post_path(Post.last))
    end

    it "does not create a post with invalid params" do
      expect {
        post posts_path, params: { post: { user_id: user.id, title: "", body: "" } }
      }.not_to change(Post, :count)

      expect(response.body).to include("error")
    end
  end

  describe "PATCH /posts/:id" do
    it "updates the post with valid params" do
      patch post_path(post_record), params: { post: { title: "Updated Title" } }
      expect(post_record.reload.title).to eq("Updated Title")
      expect(response).to redirect_to(post_path(post_record))
    end

    it "does not update the post with invalid params" do
      patch post_path(post_record), params: { post: { title: "" } }
      expect(post_record.reload.title).not_to eq("")
      expect(response.body).to include("error")
    end
  end

  describe "DELETE /posts/:id" do
    it "destroys the post" do
      expect {
        delete post_path(post_record)
      }.to change(Post, :count).by(-1)

      expect(response).to redirect_to(posts_path)
    end
  end
end
