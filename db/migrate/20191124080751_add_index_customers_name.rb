class AddIndexCustomersName < ActiveRecord::Migration[5.2]
  def change
    add_index :customers, :name, unique: true
  end
end
