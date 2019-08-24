class AddCustomersName < ActiveRecord::Migration[5.2]
  def change
    add_column :customer_contacts, :unit_name, :string
    add_column :customer_contacts, :project_name, :string
  end
end
