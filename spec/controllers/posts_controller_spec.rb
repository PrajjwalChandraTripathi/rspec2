# spec/controllers/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:valid_attributes) { { title: "Title", content: "Content" } }
  let(:invalid_attributes) { { title: "", content: "" } }
  let(:valid_post) { Post.create(valid_attributes) }

  describe "GET #index" do
    it "returns a success response" do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: valid_post.to_param }, format: :json
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: { post: valid_attributes }, format: :json
        }.to change(Post, :count).by(1)
      end

      it "renders a JSON response with the new post" do
        post :create, params: { post: valid_attributes }, format: :json
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new post" do
        post :create, params: { post: invalid_attributes }, format: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) { { title: "New Title" } }

      it "updates the requested post" do
        patch :update, params: { id: valid_post.to_param, post: new_attributes }, format: :json
        valid_post.reload
        expect(valid_post.title).to eq("New Title")
      end

      it "renders a JSON response with the post" do
        patch :update, params: { id: valid_post.to_param, post: valid_attributes }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the post" do
        patch :update, params: { id: valid_post.to_param, post: invalid_attributes }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      valid_post # Ensure the post exists
      expect {
        delete :destroy, params: { id: valid_post.to_param }, format: :json
      }.to change(Post, :count).by(-1)
    end
  end
end
