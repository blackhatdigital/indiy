class AddColumnToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :product_id, :string
    remove_column :payments, :product
  end
end
