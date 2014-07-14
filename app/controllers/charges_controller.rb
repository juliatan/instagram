class ChargesController < ApplicationController
  def new
    @post = Post.find params[:post_id]
  end

  def create
    # Amount in cents
    @amount = 1000
    @post = Post.find params[:post_id]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail], # or current_user.email
      :card => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount,
      :description => "Print of #{@post.title}",
      :currency => 'gbp'
    )

    Order.create(user: current_user, post: @post)

    flash[:notice] = 'Thanks for your payment'
    redirect_to posts_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to post_charges_path(@post)
  
  end

end
