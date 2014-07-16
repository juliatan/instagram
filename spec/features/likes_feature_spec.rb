require 'rails_helper'

describe 'liking posts' do
  before do
    julia = User.create(name: 'Julia', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
    julia.posts.create(title: 'Test post', description: 'Test description')
  end
  
  it 'is initially at 0 likes' do
    visit '/posts'
    expect(page).to have_link "❤ 0"
  end
end