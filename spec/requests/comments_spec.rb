require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:post_record) { create(:post, user: user) }
  let!(:comment) { create(:comment, user: user, post: post_record) }

  describe "GET /comments" do
    it "renders index successfully" do
      get comments_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(comment.content)
    end
  end

  describe "GET /comments/:id" do
    it "renders show successfully" do
      get comment_path(comment)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(comment.content)
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
        post comments_path, params: { comment: { user_id: nil, post_id: nil, content: "" } }
      }.not_to change(Comment, :count)

      expect(response.body).to include("error")
    end
  end

  describe "PATCH /comments/:id" do
    it "updates a comment with valid params" do
      patch comment_path(comment), params: { comment: { content: "Updated content" } }
      expect(comment.reload.content).to eq("Updated content")
      expect(response).to redirect_to(comment_path(comment))
    end

    it "does not update a comment with invalid params" do
      patch comment_path(comment), params: { comment: { content: "" } }
      expect(comment.reload.content).not_to eq("")
      expect(response.body).to include("error")
    end
  end

  describe "DELETE /comments/:id" do
    it "destroys a comment" do
      expect {
        delete comment_path(comment)
      }.to change(Comment, :count).by(-1)

      expect(response).to redirect_to(comments_path)
    end
  end
end
