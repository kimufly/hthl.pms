class AddUserPrice < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :price, :float, defaultValue: 0
  end
end
