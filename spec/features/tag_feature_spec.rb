require 'rails_helper'

describe 'Tagging posts' do
  context 'when logged in' do
    
    let!(:julia) { User.create(name: 'Julia', email: 'test@test.com', password: '12345678', password_confirmation: '12345678') }
    
    before do
      login_as julia
    end

    it 'displays tag when a post is added' do
      visit '/posts/new'
      fill_in 'Title', with: 'Cool post'
      fill_in 'Description', with: 'Hello world'
      fill_in 'Tags', with: '#yolo, #swag'
      click_button 'Post It!'
      expect(current_path).to eq '/posts'
      expect(page).to have_link "#yolo"
      expect(page).to have_link "#swag"
    end

    context 'existing posts' do
      before do
        julia.posts.create(title: 'Pic1', description: 'Hello world', tag_names: '#yolo')
        julia.posts.create(title: 'Pic2', description: 'Hello world', tag_names: '#swag')
        visit '/posts'
      end

      it 'should filter posts by selected tag' do
        click_link '#yolo'
        expect(page).to have_content 'Pic1'
        expect(page).not_to have_content 'Pic2'
        expect(page).to have_css 'h1', 'Posts tagged with #yolo'
      end

      it 'uses the tag name in the url' do
        click_link '#yolo'
        expect(current_path).to eq '/tags/yolo'
      end
    end
  end
end