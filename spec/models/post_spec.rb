# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "CRUD operations" do
    let(:valid_attributes) { { title: "Title", content: "Content" } }

    it "creates a new post" do
      post = Post.create(valid_attributes)
      expect(post).to be_valid
    end

    it "reads a post" do
      post = Post.create(valid_attributes)
      expect(Post.find(post.id)).to eq(post)
    end

    it "updates a post" do
      post = Post.create(valid_attributes)
      new_title = "New Title"
      post.update(title: new_title)
      expect(post.reload.title).to eq(new_title)
    end

    it "deletes a post" do
      post = Post.create(valid_attributes)
      post.destroy
      expect(Post.find_by(id: post.id)).to be_nil
    end
  end
end
