require 'rails_helper'

describe 'orders page' do
  let(:post){ Post.create }
  let(:user){ User.create name: 'Test', email: 'test@test.com', password: '12345678', password_confirmation: '12345678' }
  let(:admin){ Admin.create email: 'admin@test.com', password: '12345678', password_confirmation: '12345678' }

  context 'logged in as admin' do
    
    before { login_as admin, scope: :admin }

    context 'no orders' do
      it 'sees a message' do
        visit '/orders'
        expect(page).to have_content 'No orders yet'
      end
    end
  end
end