class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  validates_presence_of :username, :email

  def stripe_connected?
    stripe_user_id.present?
  end
end