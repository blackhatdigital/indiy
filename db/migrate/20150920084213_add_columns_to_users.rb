class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :publishable_key, :string
    add_column :users, :secret_key, :string
    add_column :users, :stripe_user_id, :string
  end
end
