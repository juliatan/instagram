require 'rails_helper'

describe 'Post' do

  let(:post) { Post.create }

  describe '#tag names=' do
    describe 'no tags' do
      it 'does nothing' do
        expect { post.tag_names = '' }.not_to raise_error
      end
    end

    describe 'one tag that does not exist' do
      it 'adds a tag to the post' do
        post.tag_names = '#yolo'
        expect(post.tags.length).to eq 1
      end
    end

    describe 'two tags that do not exist' do
      it 'adds both tags to the post' do
        post.tag_names = '#yolo #swag'
        expect(post.tags.length).to eq 2
      end
    end
  end
end