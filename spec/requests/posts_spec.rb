RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "renders index successfully" do
      create_list(:post, 2)
      get posts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /posts" do
    let(:user) { create(:user) }

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

      expect(response.body).to include("error") # assumes error messages rendered
    end
  end
end
