class Order < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  after_create :send_confirmation_email

  def number
      date_section = created_at.strftime('%d%m%y')
      number_section = "%04d" % id # alias for sprintf == "%04d".%(id)

      date_section + number_section
  end

  def send_confirmation_email
    OrderMailer.confirmation(self).deliver
  end
end
