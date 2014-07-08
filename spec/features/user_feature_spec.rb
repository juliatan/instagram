require 'rails_helper'

describe 'User registration and login' do

  it 'can sign up' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_button 'Sign up'
    expect(page).to have_content 'signed up successfully'
  end


end