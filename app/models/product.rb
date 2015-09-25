class Product < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  validates_presence_of [:name,:price,:short_description]
  mount_uploader :product_image, ImageUploader
  mount_uploader :product_file, ProductUploader

  def pretty_price
    "$#{price.to_i/100.0}"
  end
end