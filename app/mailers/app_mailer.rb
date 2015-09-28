class AppMailer < ActionMailer::Base
  default from: "thomas.peter.hughes@gmail.com"
  def welcome_email(user_id)
    @user = User.find(user_id)
    mail(to: @user.email, subject: "Welcome to Indiy")
  end

  def payment_invoice(payment_id)
    @payment = Payment.find(payment_id)
    mail(to: @payment.email, subject: "#{@payment.product.name} | Payment Invoice")
  end
end