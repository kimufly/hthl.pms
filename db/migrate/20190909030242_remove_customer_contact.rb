class RemoveCustomerContact < ActiveRecord::Migration[5.2]
  def up
    remove_column :customer_contacts, :unit_name
    remove_column :customer_contacts, :project_name
  end

  def down 
    add_column :customer_contacts, :unit_name, :string
    add_column :customer_contacts, :project_name, :string 
  end
end
