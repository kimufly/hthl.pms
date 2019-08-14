# This migration comes from role_core (originally 20170705174003)
class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.text :permissions

      t.string :type, null: false

      t.timestamps
    end
  end
end
