require 'rails_helper'

describe 'ordering' do
  let(:post){ Post.create title: 'Pretty picture', description: 'voldemort'}
  let(:user){ User.create name: 'Test', email: 'test@test.com', password: '12345678', password_confirmation: '12345678' }

  describe 'orders page' do
    let(:admin){ Admin.create email: 'admin@test.com', password: '12345678', password_confirmation: '12345678' }

    context 'logged in as admin' do
      context 'no orders' do
        
        before do
          login_as admin, scope: :admin
          visit '/orders'
        end

        it 'sees a message' do
          expect(page).to have_content 'No orders yet'
        end
      end

      context 'with orders' do
        
        before do
          login_as admin, scope: :admin
          christmas_day = Date.new(2013, 12, 25)

          Order.create(id: 1, post: post, user: user, created_at: christmas_day)
          visit '/orders'
        end

        it 'displays the product' do
          expect(page).to have_content 'Pretty picture'
        end

        it 'displays the customer email' do
          expect(page).to have_content 'test@test.com'
        end

        it 'displays an order number' do
          expect(page).to have_content '2512130001'
        end
      end
    end

    context 'not logged in' do
      it 'prompts you to sign in' do
        visit '/orders'
        expect(page).to have_content 'Sign in'
      end
    end
  end

  describe 'confirmation email' do

    before do
      clear_emails
    end

    it 'sends a confirmation email when an order is created' do
      Order.create(post: post, user: user)
      open_email("test@test.com")
      expect(current_email.subject).to have_content "Pretty picture"
      expect(current_email).to have_content "You've successfully ordered a Pretty picture"
    end
  end
end


