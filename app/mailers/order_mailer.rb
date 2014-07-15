class OrderMailer < ActionMailer::Base
  default from: "no-reply@instacat.com"

  def confirmation(order)
    mail(to: order.user.email, subject: "You've successfully ordered a Pretty picture")
  end
end
