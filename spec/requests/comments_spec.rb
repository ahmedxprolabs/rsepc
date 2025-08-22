require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:post_record) { create(:post, user: user) }

  describe "GET /comments" do
    it "renders index successfully" do
      create_list(:comment, 2, user: user, post: post_record)
      get comments_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(Comment.first.content)
    end
  end

  describe "POST /comments" do
    it "creates a comment with valid params" do
      expect {
        post comments_path, params: { comment: { user_id: user.id, post_id: post_record.id, content: "Nice post!" } }
      }.to change(Comment, :count).by(1)

      expect(response).to redirect_to(comment_path(Comment.last))
    end

    it "does not create a comment with invalid params" do
      expect {
        post comments_path, params: { comment: { user_id: user.id, post_id: post_record.id, content: "" } }
      }.not_to change(Comment, :count)

      expect(response.body).to include("error")
    end
  end
end
