class Product < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  validates_presence_of [:name,:price,:short_description]
  mount_uploader :product_image, ImageUploader
  mount_uploader :product_file, ProductUploader

  def sales_today
    @payments = Payment.where(product_id: id, created_at: (Time.now.beginning_of_day)..(Time.now))
    @payments.map(&:price).reduce(:+)
  end

  def sales_week
    @payments = Payment.where(product_id: id, created_at: (7.days.ago)..(Time.now))
    @payments.map(&:price).reduce(:+)
  end

  def sales_month
    @payments = Payment.where(product_id: id, created_at: (1.month.ago)..(Time.now))
    @payments.map(&:price).reduce(:+)
  end

  def sales_total
    @payments = Payment.where(product_id: id)
    @payments.map(&:price).reduce(:+)
  end

  def sales(day)
    @payments = Payment.where(product_id: id, created_at: (day.beginning_of_day)..(day.end_of_day))
    @payments.map(&:price).reduce(:+)
  end
end