require 'rails_helper'

describe 'Displaying posts' do

  context 'no posts' do
    it 'shows no posts' do
      visit '/posts'
      expect(page).to have_content "No posts yet!"
      expect(page).to have_link "Add post"
    end
  end

  context 'has posts' do
    before do
      julia = User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      julia.posts.create(title: 'Cool post', description: 'Hello world')
    end

    it 'displays posts' do
      visit '/posts'
      expect(page).to have_content "Cool post"
    end
  end
end

describe 'Creating posts' do

  context 'when logged out' do
    it 'cannot add a post' do
      visit '/posts'
      click_link 'Add post'
      expect(page).to have_content "Sign in"
      expect(page).not_to have_field "Title"
    end
  end

  context 'when logged in' do

    before do
      julia = User.create(email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      login_as julia
    end

    it 'can add a post' do
      visit '/posts/new'
      fill_in 'Title', with: 'Cool post'
      fill_in 'Description', with: 'Hello world'
      click_button 'Post It!'
      expect(current_path).to eq '/posts'
      expect(page).to have_content "Cool post"
      expect(page).to have_content "Hello world"
      expect(page).to have_content "Posted by test@test.com"
      expect(page).not_to have_css "img.uploaded-pic"
    end

    it 'can upload a photo to the post' do
      visit '/posts/new'
      fill_in 'Title', with: 'Cool post'
      fill_in 'Description', with: 'Hello world'
      attach_file 'Image', Rails.root.join('spec/images/kittycats.jpg')
      click_button 'Post It!'
      expect(current_path).to eq posts_path
      expect(page).to have_css "img.uploaded-pic"
    end

  end
end

