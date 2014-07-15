class OrderMailer < ActionMailer::Base
  default from: "no-reply@instacat.com"

  def confirmation(order)
    @order = order
    mail(to: order.user.email, subject: "You've successfully ordered a #{order.post.title}")
  end
end
