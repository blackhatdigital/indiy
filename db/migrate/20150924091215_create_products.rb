class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :short_description
      t.text :long_description
      t.string :product_image
      t.string :product_file
      t.string :user_id
      t.timestamps
    end
  end
end
