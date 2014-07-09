require 'rails_helper'

describe 'Tagging posts' do
  context 'when logged in' do
    before do
      julia = User.create(name: 'Julia', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
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

  end
end