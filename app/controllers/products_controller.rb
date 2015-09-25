class ProductsController < ApplicationController
  before_action :logged_in_only
  def new
    if !current_user.stripe_connected?
      flash[:danger] = "You need to connect to Stripe before you can upload a product."
      redirect_to user_path(current_user)
    else
      @user = current_user
      @product = Product.new
    end
  end

  def create
    @user = current_user
    @product = Product.new(product_params)
    @product.user = @user
    if @product.save
      flash[:success] = "Product Uploaded Successfully."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
    @user = @product.user
  end

  private
  def product_params
    params.require(:product).permit(:name,:price,:short_description,:long_description,:user,:product_image,:product_file)
  end
end