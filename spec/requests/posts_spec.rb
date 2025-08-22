require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "renders index successfully" do
      create_list(:post, 2)
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(Post.first.title)
    end
  end

  describe "POST /posts" do
    it "creates a post" do
      user = create(:user)

      expect {
        post posts_path, params: { post: { user_id: user.id, title: "New Post", body: "Hello" } }
      }.to change(Post, :count).by(1)

      expect(response).to redirect_to(post_path(Post.last))
    end
  end
end
