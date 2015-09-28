class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  validates_presence_of :username, :email

  def stripe_connected?
    stripe_user_id.present?
  end

  def total_sales
    sum = 0
    Product.where(user_id: id).each do |product|
      sum += product.payments.map(&:price).reduce(:+)
    end
    sum
  end
end