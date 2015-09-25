class PaymentsController < ApplicationController
  def index
    @payments = Product.find(params[:product_id]).payments
  end


  def create
    @product = Product.find(params[:product_id])
    stripe_payment = StripeWrapper::Charge.create(amount: @product.price, source: params[:stripeToken],description: @product.name,application_fee: (@product.price.to_i/10), account: @product.user.stripe_user_id)
    if stripe_payment.successful?
      @payment = Payment.new(name: params[:payment][:name],email: params[:payment][:email],product: @product, price: @product.price)
      @payment.save
      flash[:success] = "Your Purchase was Successful! We have sent the product to your email."
      redirect_to user_product_path(@product.user,@product)
    else
      flash[:danger] = stripe_payment.error_message
      @user = @product.user
      @payment = Payment.new     
      render :new
    end
  end

  def new
    @user = User.find(params[:user_id])
    @product = Product.find(params[:product_id])
    @payment = Payment.new
  end
end