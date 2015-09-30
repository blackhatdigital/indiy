class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  validates_presence_of :username, :email

  def stripe_connected?
    stripe_user_id.present?
  end

  def total_sales
    sum = 0
    @products = Product.where(user_id: id)
    if @products
      @products.each do |product|
        sum += product.payments.map(&:price).reduce(:+) if product.payments.present?
      end
    end
    sum
  end
end