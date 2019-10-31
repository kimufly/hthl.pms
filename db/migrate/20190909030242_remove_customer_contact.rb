class RemoveCustomerContact < ActiveRecord::Migration[5.2]
  def up
    remove_column :customer_contacts, :unit_name if column_exists? :customer_contacts, :unit_name
    remove_column :customer_contacts, :project_name if column_exists? :customer_contacts, :project_name
  end

  def down 
    add_column :customer_contacts, :unit_name, :string unless column_exists? :customer_contacts, :unit_name
    add_column :customer_contacts, :project_name, :string unless column_exists? :customer_contacts, :project_name
  end
end
