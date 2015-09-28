class Payment < ActiveRecord::Base
  belongs_to :product
  default_scope do
    order('created_at DESC')
  end
end