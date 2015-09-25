class Payments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :name
      t.string :email
      t.string :product
      t.integer :price
      t.string :receipt
      t.timestamps
    end
  end
end
