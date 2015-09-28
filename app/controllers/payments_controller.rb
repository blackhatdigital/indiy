class PaymentsController < ApplicationController
  before_filter :logged_in_only, only: :index

  def index
    @payments = Product.find(params[:product_id]).payments
  end


  def create
    @product = Product.find(params[:product_id])
    @stripe_payment = StripeWrapper::Charge.create(amount: @product.price, source: params[:stripeToken],description: @product.name,application_fee: (@product.price.to_i/10), account: @product.user.stripe_user_id)
    if @stripe_payment.successful?
      @payment = Payment.new(name: params[:payment][:name],email: params[:payment][:email],product: @product, price: @product.price, receipt: @stripe_payment.receipt)
      @payment.save
      AppMailer.delay.payment_invoice(@payment.id)
      flash[:success] = "Your Purchase was Successful! Click the link bellow to download your product."
      redirect_to user_product_payment_path(@product.user,@product,@payment,:params => {email: @payment.email})
    else
      flash[:danger] = @stripe_payment.error_message
      @user = @product.user
      @payment = Payment.new     
      render :new
    end
  end

  def show
    @product = Product.find(params[:product_id])
    @payment = Payment.find(params[:id])
    if params[:email] != @payment.email
      flash[:danger] = "You are not authorised to access that page."
      redirect_to root_path
    end
  end

  def new
    @user = User.find(params[:user_id])
    @product = Product.find(params[:product_id])
    @payment = Payment.new
  end
end