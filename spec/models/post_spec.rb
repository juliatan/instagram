require 'rails_helper'

describe 'Post' do

  let(:post) { Post.create }

  # place these tags here since tags are created and displayed on posts
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
        post.tag_names = '#yolo, #swag'
        expect(post.tags.length).to eq 2
      end
    end

    describe 'tag already exists' do
      
      # note that ! asks the let to create the tag immediately otherwise
      # rspec will normally wait until it has to do it (lazy)
      # let! is the same as before
      let!(:existing_tag) { Tag.create(name: '#yolo')}
      
      it 'reuses existing tag' do
        post.tag_names = '#yolo' # i.e. new post tagging existing tag
        expect(post.tags).to include existing_tag
        expect(Tag.count).to eq 1
      end
    end
  end
end